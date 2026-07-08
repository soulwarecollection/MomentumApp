import 'package:drift/drift.dart' show Value, Variable;
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/db/tables/metrics_converter.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/logging/domain/entities/exercise_entry.dart';
import 'package:momentum/features/logging/domain/entities/last_session_summary.dart';
import 'package:momentum/features/logging/domain/repositories/logging_repository.dart';

@LazySingleton(as: LoggingRepository)
class LoggingRepositoryImpl implements LoggingRepository {
  LoggingRepositoryImpl(this._db);

  final AppDatabase _db;

  SessionsDao get _sessions => _db.sessionsDao;

  @override
  TaskEither<Failure, int> createSession({
    int? planId,
    int? dayIndex,
    String? focus,
  }) {
    return TaskEither.tryCatch(
      () async {
        final now = DateTime.now();
        return _sessions.insertSession(
          SessionsCompanion.insert(
            startedAt: now,
            updatedAt: now,
            planId: Value(planId),
            dayIndex: Value(dayIndex),
            focus: Value(focus),
          ),
        );
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> finishSession({
    required int sessionId,
    required DateTime endedAt,
    required int durationSeconds,
    required List<ExerciseEntry> exercises,
    int? planId,
    int? dayIndex,
  }) {
    return TaskEither.tryCatch(
      () => _db.transaction(() async {
        final now = DateTime.now();

        // Update session row
        await _sessions.markSessionFinished(
          sessionId,
          endedAt: endedAt,
          durationSeconds: durationSeconds,
          updatedAt: now,
        );

        // Write exercises + sets
        for (var i = 0; i < exercises.length; i++) {
          final ex = exercises[i];
          if (ex.sets.isEmpty) continue;

          final exId = await _sessions.insertSessionExercise(
            SessionExercisesCompanion.insert(
              sessionId: sessionId,
              orderIndex: i,
              name: ex.name,
              modality: ex.modality,
              equipment: Value(ex.equipment),
              exerciseNote: Value(ex.exerciseNote),
            ),
          );

          for (var j = 0; j < ex.sets.length; j++) {
            final row = ex.sets[j];
            await _db.loggedSetsDao.insertLoggedSet(
              LoggedSetsCompanion.insert(
                sessionExerciseId: exId,
                orderIndex: j,
                modality: ex.modality,
                metrics: row.metrics,
                createdAt: now,
                isDone: Value(row.isDone),
              ),
            );
          }
        }

        // Advance rotation cursor if this was a plan session
        if (planId != null && dayIndex != null) {
          await _advanceCursor(planId, dayIndex);
        }

        return unit;
      }),
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  Future<void> _advanceCursor(int planId, int currentDayIndex) async {
    final days = await _db.plansDao.getPlanDays(planId);
    if (days.isEmpty) return;
    final total = days.length;
    var next = (currentDayIndex + 1) % total;
    var guard = 0;
    while (days[next].isRest && guard < total) {
      next = (next + 1) % total;
      guard++;
    }
    await _db.plansDao.advanceCursor(planId, next);
  }

  @override
  TaskEither<Failure, double?> getBestOneRepMax(String exerciseName) {
    return TaskEither.tryCatch(
      () async {
        final rows = await _db
            .customSelect(
              'SELECT ls.metrics FROM logged_sets ls '
              'JOIN session_exercises se '
              '  ON ls.session_exercise_id = se.id '
              'WHERE se.name = ? '
              '  AND ls.modality = ? '
              '  AND ls.is_done = 1',
              variables: [
                Variable.withString(exerciseName),
                Variable.withString(Modality.strength.name),
              ],
              readsFrom: {_db.loggedSets, _db.sessionExercises},
            )
            .get();

        const converter = MetricsConverter();
        double best = 0;
        for (final row in rows) {
          final metrics = converter.fromSql(
            row.read<String>('metrics'),
          );
          final w = metrics['weight'] ?? 0;
          final r = metrics['reps'] ?? 0;
          if (w > 0 && r > 0) {
            final orm = w * (1 + r / 30);
            if (orm > best) best = orm;
          }
        }
        return best > 0 ? best : null;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, LastSessionSummary?> getLastSessionSummary(
    String exerciseName,
  ) {
    return TaskEither.tryCatch(
      () async {
        // Find the most recent finished session containing this exercise.
        final sessionRows = await _db
            .customSelect(
              'SELECT s.id FROM sessions s '
              'JOIN session_exercises se ON se.session_id = s.id '
              'WHERE se.name = ? AND s.is_done = 1 '
              'ORDER BY s.ended_at DESC LIMIT 1',
              variables: [Variable.withString(exerciseName)],
              readsFrom: {_db.sessions, _db.sessionExercises},
            )
            .get();
        if (sessionRows.isEmpty) return null;
        final sessionId = sessionRows.first.read<int>('id');

        // Get all completed sets for that exercise in that session, in
        // the order they were logged.
        final setRows = await _db
            .customSelect(
              'SELECT ls.metrics FROM logged_sets ls '
              'JOIN session_exercises se '
              '  ON ls.session_exercise_id = se.id '
              'WHERE se.session_id = ? AND se.name = ? '
              '  AND ls.is_done = 1 '
              'ORDER BY ls.order_index ASC',
              variables: [
                Variable.withInt(sessionId),
                Variable.withString(exerciseName),
              ],
              readsFrom: {_db.loggedSets, _db.sessionExercises},
            )
            .get();
        if (setRows.isEmpty) return null;

        const converter = MetricsConverter();
        double? maxWeight;
        final setMetrics = <Map<String, double>>[];
        for (final row in setRows) {
          final metrics = converter.fromSql(row.read<String>('metrics'));
          setMetrics.add(metrics);
          final w = metrics['weight'];
          if (w != null && w > 0) {
            if (maxWeight == null || w > maxWeight) maxWeight = w;
          }
        }

        return LastSessionSummary(
          setCount: setRows.length,
          maxWeightKg: maxWeight,
          setMetrics: setMetrics,
        );
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }
}
