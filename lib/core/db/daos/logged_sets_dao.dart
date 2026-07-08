import 'package:drift/drift.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/db/tables/logged_sets_table.dart';

part 'logged_sets_dao.g.dart';

@DriftAccessor(tables: [LoggedSets])
class LoggedSetsDao extends DatabaseAccessor<AppDatabase>
    with _$LoggedSetsDaoMixin {
  LoggedSetsDao(super.attachedDatabase);

  // ── Watch queries ─────────────────────────────────────────────────

  Stream<List<LoggedSetRow>> watchLoggedSets(int sessionExerciseId) {
    final q = select(db.loggedSets)
      ..where((t) => t.sessionExerciseId.equals(sessionExerciseId))
      ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]);
    return q.watch();
  }

  // ── Writes ────────────────────────────────────────────────────────

  Future<int> insertLoggedSet(LoggedSetsCompanion s) =>
      into(db.loggedSets).insert(s);

  Future<bool> updateLoggedSet(LoggedSetsCompanion s) =>
      update(db.loggedSets).replace(s);

  Future<int> deleteLoggedSet(int id) =>
      (delete(db.loggedSets)..where((t) => t.id.equals(id))).go();

  Future<void> toggleSetDone(int id, {required bool isDone}) async {
    await (update(db.loggedSets)..where((t) => t.id.equals(id))).write(
      LoggedSetsCompanion(isDone: Value(isDone)),
    );
  }

  Future<int> deleteLoggedSets(int sessionExerciseId) =>
      (delete(db.loggedSets)..where(
            (t) => t.sessionExerciseId.equals(sessionExerciseId),
          ))
          .go();

  // ── Sync helpers ──────────────────────────────────────────────────

  Future<List<LoggedSetRow>> getLoggedSetsModifiedSince(DateTime since) =>
      (select(db.loggedSets)..where(
            (t) =>
                t.updatedAt.isNotNull() & t.updatedAt.isBiggerThanValue(since),
          ))
          .get();

  Future<LoggedSetRow?> getLoggedSetByRemoteId(String remoteId) => (select(
    db.loggedSets,
  )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

  Future<void> setLoggedSetRemoteId(int localId, String remoteId) =>
      customUpdate(
        'UPDATE logged_sets SET remote_id = ? WHERE id = ?',
        variables: [Variable<String>(remoteId), Variable<int>(localId)],
        updates: {db.loggedSets},
      );
}
