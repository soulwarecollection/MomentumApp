import 'package:drift/drift.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/db/tables/session_exercises_table.dart';
import 'package:momentum/core/db/tables/sessions_table.dart';

part 'sessions_dao.g.dart';

@DriftAccessor(tables: [Sessions, SessionExercises])
class SessionsDao extends DatabaseAccessor<AppDatabase>
    with _$SessionsDaoMixin {
  SessionsDao(super.attachedDatabase);

  // ── Watch queries ─────────────────────────────────────────────────

  Stream<List<SessionRow>> watchActiveSessions() {
    final q = select(db.sessions)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]);
    return q.watch();
  }

  Stream<List<SessionExerciseRow>> watchSessionExercises(
    int sessionId,
  ) {
    final q = select(db.sessionExercises)
      ..where((t) => t.sessionId.equals(sessionId))
      ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]);
    return q.watch();
  }

  // ── Single reads ──────────────────────────────────────────────────

  Future<SessionRow?> getSession(int id) =>
      (select(db.sessions)..where((t) => t.id.equals(id))).getSingleOrNull();

  // ── Writes ────────────────────────────────────────────────────────

  Future<int> insertSession(SessionsCompanion session) =>
      into(db.sessions).insert(session);

  Future<bool> updateSession(SessionsCompanion session) =>
      update(db.sessions).replace(session);

  Future<void> markSessionFinished(
    int id, {
    required DateTime endedAt,
    required int durationSeconds,
    required DateTime updatedAt,
  }) async {
    await (update(db.sessions)..where((t) => t.id.equals(id))).write(
      SessionsCompanion(
        endedAt: Value(endedAt),
        durationSeconds: Value(durationSeconds),
        updatedAt: Value(updatedAt),
      ),
    );
  }

  Future<int> countWeekSessions() async {
    final now = DateTime.now();
    final monday = DateTime(now.year, now.month, now.day - (now.weekday - 1));
    final rows =
        await (select(db.sessions)..where(
              (t) =>
                  t.startedAt.isBiggerOrEqualValue(monday) &
                  t.deletedAt.isNull(),
            ))
            .get();
    return rows.length;
  }

  Stream<List<SessionRow>> watchRecentSessions({int limit = 3}) =>
      (select(db.sessions)
            ..where((t) => t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
            ..limit(limit))
          .watch();

  Future<void> softDeleteSession(int id) async {
    await (update(db.sessions)..where((t) => t.id.equals(id))).write(
      SessionsCompanion(deletedAt: Value(DateTime.now())),
    );
  }

  Future<int> insertSessionExercise(
    SessionExercisesCompanion ex,
  ) => into(db.sessionExercises).insert(ex);

  Future<int> deleteSessionExercises(int sessionId) => (delete(
    db.sessionExercises,
  )..where((t) => t.sessionId.equals(sessionId))).go();

  // ── Sync helpers ──────────────────────────────────────────────────

  Future<List<SessionRow>> getSessionsModifiedSince(DateTime since) => (select(
    db.sessions,
  )..where((t) => t.updatedAt.isBiggerThanValue(since))).get();

  Future<List<SessionExerciseRow>> getSessionExercisesModifiedSince(
    DateTime since,
  ) =>
      (select(db.sessionExercises)..where(
            (t) =>
                t.updatedAt.isNotNull() & t.updatedAt.isBiggerThanValue(since),
          ))
          .get();

  Future<SessionRow?> getSessionByRemoteId(String remoteId) => (select(
    db.sessions,
  )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

  Future<SessionExerciseRow?> getSessionExerciseByRemoteId(
    String remoteId,
  ) => (select(
    db.sessionExercises,
  )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

  Future<void> setSessionRemoteId(int localId, String remoteId) => customUpdate(
    'UPDATE sessions SET remote_id = ? WHERE id = ?',
    variables: [Variable<String>(remoteId), Variable<int>(localId)],
    updates: {db.sessions},
  );

  Future<void> setSessionExerciseRemoteId(
    int localId,
    String remoteId,
  ) => customUpdate(
    'UPDATE session_exercises SET remote_id = ? WHERE id = ?',
    variables: [Variable<String>(remoteId), Variable<int>(localId)],
    updates: {db.sessionExercises},
  );
}
