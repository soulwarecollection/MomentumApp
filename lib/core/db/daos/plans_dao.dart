import 'package:drift/drift.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/db/tables/plan_days_table.dart';
import 'package:momentum/core/db/tables/plan_exercises_table.dart';
import 'package:momentum/core/db/tables/plans_table.dart';

part 'plans_dao.g.dart';

@DriftAccessor(tables: [Plans, PlanDays, PlanExercises])
class PlansDao extends DatabaseAccessor<AppDatabase> with _$PlansDaoMixin {
  PlansDao(super.attachedDatabase);

  // ── Watch queries ─────────────────────────────────────────────────

  Stream<List<PlanRow>> watchActivePlans() {
    final q = select(db.plans)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
    return q.watch();
  }

  Stream<List<PlanDayRow>> watchPlanDays(int planId) {
    final q = select(db.planDays)
      ..where((t) => t.planId.equals(planId))
      ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]);
    return q.watch();
  }

  Stream<List<PlanExerciseRow>> watchPlanExercises(int planDayId) {
    final q = select(db.planExercises)
      ..where((t) => t.planDayId.equals(planDayId))
      ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]);
    return q.watch();
  }

  /// All exercises for [planId] joined through their parent day,
  /// ordered by day then exercise `orderIndex`.
  Stream<List<PlanExerciseRow>> watchAllExercisesForPlan(int planId) {
    return (select(db.planExercises).join([
            innerJoin(
              db.planDays,
              db.planDays.id.equalsExp(db.planExercises.planDayId),
            ),
          ])
          ..where(db.planDays.planId.equals(planId))
          ..orderBy([
            OrderingTerm.asc(db.planDays.orderIndex),
            OrderingTerm.asc(db.planExercises.orderIndex),
          ]))
        .watch()
        .map(
          (rows) => rows.map((r) => r.readTable(db.planExercises)).toList(),
        );
  }

  // ── Single reads ──────────────────────────────────────────────────

  Future<PlanRow?> getPlan(int id) =>
      (select(db.plans)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<PlanDayRow>> getPlanDays(int planId) =>
      (select(db.planDays)
            ..where((t) => t.planId.equals(planId))
            ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
          .get();

  Future<List<PlanExerciseRow>> getPlanExercises(int planDayId) =>
      (select(db.planExercises)
            ..where((t) => t.planDayId.equals(planDayId))
            ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
          .get();

  // ── Single reads ─ (plans) ────────────────────────────────────────

  Future<int> nextSortOrder() async {
    final rows =
        await (select(db.plans)
              ..where((t) => t.deletedAt.isNull())
              ..orderBy([(t) => OrderingTerm.desc(t.sortOrder)])
              ..limit(1))
            .get();
    return rows.isEmpty ? 0 : rows.first.sortOrder + 1;
  }

  // ── Plan writes ───────────────────────────────────────────────────

  Future<int> insertPlan(PlansCompanion plan) => into(db.plans).insert(plan);

  Future<void> writePlan(int id, PlansCompanion companion) async {
    await (update(db.plans)..where((t) => t.id.equals(id))).write(companion);
  }

  Future<void> reorderPlans(List<int> orderedIds) {
    return db.transaction(() async {
      for (var i = 0; i < orderedIds.length; i++) {
        await (update(db.plans)..where((t) => t.id.equals(orderedIds[i])))
            .write(PlansCompanion(sortOrder: Value(i)));
      }
    });
  }

  Future<void> softDeletePlan(int id) async {
    await (update(db.plans)..where((t) => t.id.equals(id))).write(
      PlansCompanion(deletedAt: Value(DateTime.now())),
    );
  }

  /// Sets [id] as the active plan and marks all others inactive.
  Future<void> setActivePlan(int id) {
    return db.transaction(() async {
      await update(
        db.plans,
      ).write(const PlansCompanion(isActive: Value(false)));
      await (update(db.plans)..where((t) => t.id.equals(id))).write(
        const PlansCompanion(isActive: Value(true)),
      );
    });
  }

  /// Advances the rotation cursor after a session completes.
  Future<void> advanceCursor(int planId, int dayIndex) async {
    await (update(db.plans)..where((t) => t.id.equals(planId))).write(
      PlansCompanion(currentDayIndex: Value(dayIndex)),
    );
  }

  // ── Day writes ────────────────────────────────────────────────────

  Future<int> insertPlanDay(PlanDaysCompanion day) =>
      into(db.planDays).insert(day);

  Future<void> writePlanDay(int id, PlanDaysCompanion companion) async {
    await (update(db.planDays)..where((t) => t.id.equals(id))).write(companion);
  }

  Future<int> deletePlanDay(int id) =>
      (delete(db.planDays)..where((t) => t.id.equals(id))).go();

  Future<int> deletePlanDays(int planId) =>
      (delete(db.planDays)..where((t) => t.planId.equals(planId))).go();

  Future<void> reorderDays(int planId, List<int> orderedIds) {
    return db.transaction(() async {
      for (var i = 0; i < orderedIds.length; i++) {
        await (update(db.planDays)..where((t) => t.id.equals(orderedIds[i])))
            .write(PlanDaysCompanion(orderIndex: Value(i)));
      }
    });
  }

  // ── Exercise writes ───────────────────────────────────────────────

  Future<int> insertPlanExercise(PlanExercisesCompanion ex) =>
      into(db.planExercises).insert(ex);

  Future<void> writePlanExercise(
    int id,
    PlanExercisesCompanion companion,
  ) async {
    await (update(
      db.planExercises,
    )..where((t) => t.id.equals(id))).write(companion);
  }

  Future<int> deletePlanExercise(int id) =>
      (delete(db.planExercises)..where((t) => t.id.equals(id))).go();

  Future<int> deletePlanExercises(int planDayId) => (delete(
    db.planExercises,
  )..where((t) => t.planDayId.equals(planDayId))).go();

  Future<void> reorderExercises(
    int planDayId,
    List<int> orderedIds,
  ) {
    return db.transaction(() async {
      for (var i = 0; i < orderedIds.length; i++) {
        await (update(db.planExercises)
              ..where((t) => t.id.equals(orderedIds[i])))
            .write(PlanExercisesCompanion(orderIndex: Value(i)));
      }
    });
  }

  // ── Sync helpers ──────────────────────────────────────────────────

  Future<List<PlanRow>> getPlansModifiedSince(DateTime since) => (select(
    db.plans,
  )..where((t) => t.updatedAt.isBiggerThanValue(since))).get();

  Future<List<PlanDayRow>> getPlanDaysModifiedSince(DateTime since) =>
      (select(db.planDays)..where(
            (t) =>
                t.updatedAt.isNotNull() & t.updatedAt.isBiggerThanValue(since),
          ))
          .get();

  Future<List<PlanExerciseRow>> getPlanExercisesModifiedSince(
    DateTime since,
  ) =>
      (select(db.planExercises)..where(
            (t) =>
                t.updatedAt.isNotNull() & t.updatedAt.isBiggerThanValue(since),
          ))
          .get();

  Future<PlanRow?> getPlanByRemoteId(String remoteId) => (select(
    db.plans,
  )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

  Future<PlanDayRow?> getPlanDayByRemoteId(String remoteId) => (select(
    db.planDays,
  )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

  Future<PlanExerciseRow?> getPlanExerciseByRemoteId(String remoteId) =>
      (select(
        db.planExercises,
      )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

  Future<void> setPlanRemoteId(int localId, String remoteId) => customUpdate(
    'UPDATE plans SET remote_id = ? WHERE id = ?',
    variables: [Variable<String>(remoteId), Variable<int>(localId)],
    updates: {db.plans},
  );

  Future<void> setPlanDayRemoteId(int localId, String remoteId) => customUpdate(
    'UPDATE plan_days SET remote_id = ? WHERE id = ?',
    variables: [Variable<String>(remoteId), Variable<int>(localId)],
    updates: {db.planDays},
  );

  Future<void> setPlanExerciseRemoteId(int localId, String remoteId) =>
      customUpdate(
        'UPDATE plan_exercises SET remote_id = ? WHERE id = ?',
        variables: [Variable<String>(remoteId), Variable<int>(localId)],
        updates: {db.planExercises},
      );
}
