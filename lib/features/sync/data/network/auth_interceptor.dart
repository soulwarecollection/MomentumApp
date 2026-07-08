import 'package:dio/dio.dart';
import 'package:momentum/features/sync/data/datasources/auth_remote_datasource.dart';
import 'package:momentum/features/sync/data/token_storage.dart';

/// Injects the access token and refreshes it transparently on 401.
///
/// Uses [_authDio] (plain Dio, no interceptors) for the refresh call and
/// for replaying original requests, so we never recurse into this interceptor.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio authDio,
    required TokenStorage storage,
    required AuthRemoteDatasource authDatasource,
  }) : _authDio = authDio,
       _storage = storage,
       _auth = authDatasource;

  final Dio _authDio;
  final TokenStorage _storage;
  final AuthRemoteDatasource _auth;

  bool _refreshing = false;
  final _queue = <_PendingRequest>[];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.readAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    if (_refreshing) {
      _queue.add(_PendingRequest(err.requestOptions, handler));
      return;
    }

    _refreshing = true;
    try {
      final refreshToken = await _storage.readRefreshToken();
      if (refreshToken == null) {
        await _storage.clear();
        await _flushQueue(null);
        handler.next(err);
        return;
      }

      final pair = await _auth.refresh(refreshToken);
      await _storage.saveTokens(pair);

      final retried = await _retry(err.requestOptions, pair.accessToken);
      handler.resolve(retried);
      await _flushQueue(pair.accessToken);
    } on Object {
      await _storage.clear();
      await _flushQueue(null);
      handler.next(err);
    } finally {
      _refreshing = false;
      _queue.clear();
    }
  }

  Future<Response<dynamic>> _retry(
    RequestOptions options,
    String newToken,
  ) => _authDio.request<dynamic>(
    options.path,
    data: options.data,
    queryParameters: options.queryParameters,
    options: Options(
      method: options.method,
      headers: {
        ...options.headers,
        'Authorization': 'Bearer $newToken',
      },
      responseType: options.responseType,
    ),
  );

  Future<void> _flushQueue(String? newToken) async {
    for (final pending in _queue) {
      if (newToken == null) {
        pending.handler.next(
          DioException(requestOptions: pending.options),
        );
      } else {
        try {
          final response = await _retry(pending.options, newToken);
          pending.handler.resolve(response);
        } on Object catch (e) {
          pending.handler.next(
            DioException(requestOptions: pending.options, error: e),
          );
        }
      }
    }
  }
}

class _PendingRequest {
  _PendingRequest(this.options, this.handler);
  final RequestOptions options;
  final ErrorInterceptorHandler handler;
}
