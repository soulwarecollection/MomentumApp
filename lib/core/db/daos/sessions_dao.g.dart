// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions_dao.dart';

// ignore_for_file: type=lint
mixin _$SessionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $PlansTable get plans => attachedDatabase.plans;
  $SessionsTable get sessions => attachedDatabase.sessions;
  $SessionExercisesTable get sessionExercises =>
      attachedDatabase.sessionExercises;
  SessionsDaoManager get managers => SessionsDaoManager(this);
}

class SessionsDaoManager {
  final _$SessionsDaoMixin _db;
  SessionsDaoManager(this._db);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db.attachedDatabase, _db.plans);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db.attachedDatabase, _db.sessions);
  $$SessionExercisesTableTableManager get sessionExercises =>
      $$SessionExercisesTableTableManager(
        _db.attachedDatabase,
        _db.sessionExercises,
      );
}
