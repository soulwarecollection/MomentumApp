import 'package:dio/dio.dart';
import 'package:momentum/features/sync/domain/entities/token_pair.dart';

class AuthRemoteDatasource {
  AuthRemoteDatasource(this._dio);

  final Dio _dio;

  Future<TokenPair> register(String email, String password) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: {'email': email, 'password': password},
    );
    return _fromJson(res.data!);
  }

  Future<TokenPair> login(String email, String password) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return _fromJson(res.data!);
  }

  Future<TokenPair> refresh(String refreshToken) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    return _fromJson(res.data!);
  }

  static TokenPair _fromJson(Map<String, dynamic> json) => TokenPair(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );
}
