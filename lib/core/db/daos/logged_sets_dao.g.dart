// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_sets_dao.dart';

// ignore_for_file: type=lint
mixin _$LoggedSetsDaoMixin on DatabaseAccessor<AppDatabase> {
  $PlansTable get plans => attachedDatabase.plans;
  $SessionsTable get sessions => attachedDatabase.sessions;
  $SessionExercisesTable get sessionExercises =>
      attachedDatabase.sessionExercises;
  $LoggedSetsTable get loggedSets => attachedDatabase.loggedSets;
  LoggedSetsDaoManager get managers => LoggedSetsDaoManager(this);
}

class LoggedSetsDaoManager {
  final _$LoggedSetsDaoMixin _db;
  LoggedSetsDaoManager(this._db);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db.attachedDatabase, _db.plans);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db.attachedDatabase, _db.sessions);
  $$SessionExercisesTableTableManager get sessionExercises =>
      $$SessionExercisesTableTableManager(
        _db.attachedDatabase,
        _db.sessionExercises,
      );
  $$LoggedSetsTableTableManager get loggedSets =>
      $$LoggedSetsTableTableManager(_db.attachedDatabase, _db.loggedSets);
}
