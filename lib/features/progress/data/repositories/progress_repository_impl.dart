import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/entities/session_exercise_detail.dart';
import 'package:momentum/features/progress/domain/entities/session_summary.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';

@LazySingleton(as: ProgressRepository)
class ProgressRepositoryImpl implements ProgressRepository {
  ProgressRepositoryImpl(this._db);

  final AppDatabase _db;

  // ── Join helper ───────────────────────────────────────────────────

  Future<List<RawSet>> _queryDoneSets({String? exerciseName}) async {
    var filter =
        _db.loggedSets.isDone.equals(true) & _db.sessions.deletedAt.isNull();

    if (exerciseName != null) {
      filter = filter & _db.sessionExercises.name.equals(exerciseName);
    }

    final results =
        await (_db.select(_db.loggedSets).join([
                innerJoin(
                  _db.sessionExercises,
                  _db.sessionExercises.id.equalsExp(
                    _db.loggedSets.sessionExerciseId,
                  ),
                ),
                innerJoin(
                  _db.sessions,
                  _db.sessions.id.equalsExp(_db.sessionExercises.sessionId),
                ),
              ])
              ..where(filter)
              ..orderBy([OrderingTerm.desc(_db.sessions.startedAt)]))
            .get();

    return results.map((row) {
      final session = row.readTable(_db.sessions);
      final exercise = row.readTable(_db.sessionExercises);
      final set = row.readTable(_db.loggedSets);
      return RawSet(
        sessionId: session.id,
        exerciseName: exercise.name,
        modality: exercise.modality,
        sessionDate: session.startedAt,
        metrics: set.metrics,
      );
    }).toList();
  }

  // ── ProgressRepository — live streams ────────────────────────────

  @override
  Stream<Either<Failure, List<RawSet>>> watchAllDoneSets() {
    final filter =
        _db.loggedSets.isDone.equals(true) & _db.sessions.deletedAt.isNull();
    return (_db.select(_db.loggedSets).join([
            innerJoin(
              _db.sessionExercises,
              _db.sessionExercises.id.equalsExp(
                _db.loggedSets.sessionExerciseId,
              ),
            ),
            innerJoin(
              _db.sessions,
              _db.sessions.id.equalsExp(_db.sessionExercises.sessionId),
            ),
          ])
          ..where(filter)
          ..orderBy([OrderingTerm.desc(_db.sessions.startedAt)]))
        .watch()
        .map<Either<Failure, List<RawSet>>>((results) {
          try {
            return right(
              results.map((row) {
                final session = row.readTable(_db.sessions);
                final exercise = row.readTable(_db.sessionExercises);
                final set = row.readTable(_db.loggedSets);
                return RawSet(
                  sessionId: session.id,
                  exerciseName: exercise.name,
                  modality: exercise.modality,
                  sessionDate: session.startedAt,
                  metrics: set.metrics,
                );
              }).toList(),
            );
          } on Object catch (e) {
            return left(CacheFailure(message: e.toString()));
          }
        });
  }

  @override
  Stream<Either<Failure, List<DateTime>>> watchSessionDates() =>
      (_db.select(_db.sessions)..where((t) => t.deletedAt.isNull()))
          .watch()
          .map<Either<Failure, List<DateTime>>>(
            (rows) => right(
              rows
                  .map(
                    (r) => DateTime(
                      r.startedAt.year,
                      r.startedAt.month,
                      r.startedAt.day,
                    ),
                  )
                  .toList(),
            ),
          );

  @override
  Stream<Either<Failure, List<SessionSummary>>> watchSessionSummaries() =>
      (_db.select(_db.sessions)..where((t) => t.deletedAt.isNull()))
          .watch()
          .asyncMap((_) => getSessionSummaries().run());

  // ── ProgressRepository — one-shot reads ──────────────────────────

  @override
  TaskEither<Failure, List<RawSet>> getDoneSetsForExercise(String name) =>
      TaskEither.tryCatch(
        () => _queryDoneSets(exerciseName: name),
        (e, _) => CacheFailure(message: e.toString()),
      );

  @override
  TaskEither<Failure, List<DateTime>> getSessionDates() => TaskEither.tryCatch(
    () async {
      final rows = await (_db.select(
        _db.sessions,
      )..where((t) => t.deletedAt.isNull())).get();
      return rows
          .map(
            (r) => DateTime(
              r.startedAt.year,
              r.startedAt.month,
              r.startedAt.day,
            ),
          )
          .toList();
    },
    (e, _) => CacheFailure(message: e.toString()),
  );

  @override
  TaskEither<Failure, List<SessionSummary>> getSessionSummaries() =>
      TaskEither.tryCatch(
        () async {
          final sessions =
              await (_db.select(_db.sessions)
                    ..where((t) => t.deletedAt.isNull())
                    ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
                  .get();
          if (sessions.isEmpty) return [];

          final sessionIds = sessions.map((s) => s.id).toList();

          final allExercises =
              await (_db.select(_db.sessionExercises)
                    ..where((t) => t.sessionId.isIn(sessionIds))
                    ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
                  .get();

          final exerciseIds = allExercises.map((e) => e.id).toList();
          final allSets = exerciseIds.isEmpty
              ? <LoggedSetRow>[]
              : await (_db.select(_db.loggedSets)..where(
                      (t) =>
                          t.sessionExerciseId.isIn(exerciseIds) &
                          t.isDone.equals(true),
                    ))
                    .get();

          final exBySession = <int, List<SessionExerciseRow>>{};
          for (final ex in allExercises) {
            (exBySession[ex.sessionId] ??= []).add(ex);
          }
          final setsByEx = <int, List<LoggedSetRow>>{};
          for (final s in allSets) {
            (setsByEx[s.sessionExerciseId] ??= []).add(s);
          }

          return sessions.map((s) {
            final exs = exBySession[s.id] ?? [];
            final sets = <LoggedSetRow>[
              for (final e in exs) ...?setsByEx[e.id],
            ];

            double totalVolume = 0;
            final modalityCounts = <Modality, int>{};
            for (final set in sets) {
              final w = set.metrics['weight'] ?? 0;
              final r = set.metrics['reps'] ?? 0;
              if (set.modality == Modality.strength && w > 0 && r > 0) {
                totalVolume += w * r;
              }
              modalityCounts[set.modality] =
                  (modalityCounts[set.modality] ?? 0) + 1;
            }

            final dominant = modalityCounts.isEmpty
                ? null
                : modalityCounts.entries
                      .reduce((a, b) => a.value >= b.value ? a : b)
                      .key;

            return SessionSummary(
              id: s.id,
              startedAt: s.startedAt,
              setCount: sets.length,
              totalVolumeKg: totalVolume,
              focus: s.focus,
              durationSeconds: s.durationSeconds,
              dominantModality: dominant,
            );
          }).toList();
        },
        (e, _) => CacheFailure(message: e.toString()),
      );

  @override
  TaskEither<Failure, SessionSummary> getSessionSummary(int id) =>
      getSessionSummaries().flatMap(
        (list) => TaskEither.fromOption(
          Option.fromNullable(list.where((s) => s.id == id).firstOrNull),
          () => const CacheFailure(message: 'Session not found'),
        ),
      );

  @override
  TaskEither<Failure, List<SessionExerciseDetail>> getSessionExercises(
    int sessionId,
  ) => TaskEither.tryCatch(
    () async {
      final exercises =
          await (_db.select(_db.sessionExercises)
                ..where((t) => t.sessionId.equals(sessionId))
                ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
              .get();

      final result = <SessionExerciseDetail>[];
      for (final ex in exercises) {
        final sets =
            await (_db.select(_db.loggedSets)
                  ..where(
                    (t) =>
                        t.sessionExerciseId.equals(ex.id) &
                        t.isDone.equals(true),
                  )
                  ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
                .get();
        result.add(
          SessionExerciseDetail(
            name: ex.name,
            modality: ex.modality,
            doneSets: sets.map((s) => s.metrics).toList(),
          ),
        );
      }
      return result;
    },
    (e, _) => CacheFailure(message: e.toString()),
  );
}
