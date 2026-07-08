import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/sync/data/datasources/auth_remote_datasource.dart';
import 'package:momentum/features/sync/data/datasources/sync_remote_datasource.dart';
import 'package:momentum/features/sync/data/network/auth_interceptor.dart';
import 'package:momentum/features/sync/data/repositories/account_repository_impl.dart';
import 'package:momentum/features/sync/data/token_storage.dart';
import 'package:momentum/features/sync/domain/repositories/account_repository.dart';
import 'package:momentum/features/sync/presentation/cubits/account_cubit.dart';
import 'package:momentum/features/sync/presentation/cubits/sync_status_cubit.dart';
import 'package:momentum/features/sync/sync_service.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

/// Registers all sync-feature dependencies manually (not via injectable
/// codegen) because the two-Dio setup cannot be expressed in annotations.
class SyncDiModule {
  SyncDiModule._();

  static Future<void> configure(GetIt sl) async {
    sl
      ..registerSingleton<FlutterSecureStorage>(
        const FlutterSecureStorage(),
      )
      ..registerSingleton<TokenStorage>(TokenStorage(sl()));

    // Auth Dio — plain, no interceptors (used for login/refresh)
    final authDio = Dio(
      BaseOptions(
        baseUrl: const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'http://localhost:3000',
        ),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    sl.registerSingleton<AuthRemoteDatasource>(
      AuthRemoteDatasource(authDio),
    );

    // API Dio — carries the AuthInterceptor for protected endpoints
    final apiDio =
        Dio(
            BaseOptions(
              baseUrl: authDio.options.baseUrl,
              connectTimeout: authDio.options.connectTimeout,
              receiveTimeout: authDio.options.receiveTimeout,
            ),
          )
          ..interceptors.add(
            AuthInterceptor(
              authDio: authDio,
              storage: sl<TokenStorage>(),
              authDatasource: sl<AuthRemoteDatasource>(),
            ),
          );

    sl
      ..registerSingleton<SyncRemoteDatasource>(
        SyncRemoteDatasource(apiDio),
      )
      ..registerSingleton<AccountRepository>(
        AccountRepositoryImpl(remote: sl(), storage: sl()),
      )
      ..registerSingleton<SyncService>(
        SyncService(
          db: sl<AppDatabase>(),
          remote: sl(),
          tokenStorage: sl(),
          prefs: sl<SharedPreferences>(),
        ),
      )
      ..registerLazySingleton<AccountCubit>(() => AccountCubit(sl()))
      ..registerLazySingleton<SyncStatusCubit>(SyncStatusCubit.new);
  }
}
