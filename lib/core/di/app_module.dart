import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  /// Opens (or creates) the on-device SQLite database.
  ///
  /// `driftDatabase` returns a `QueryExecutor` synchronously; the
  /// connection is opened lazily on first query.
  @singleton
  AppDatabase get database => AppDatabase(driftDatabase(name: 'momentum'));
}
