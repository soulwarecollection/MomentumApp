import 'package:drift/drift.dart' show Value;
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/routines/data/mappers/plan_mappers.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';

@LazySingleton(as: RoutinesRepository)
class RoutinesRepositoryImpl implements RoutinesRepository {
  RoutinesRepositoryImpl(this._db);

  final AppDatabase _db;

  PlansDao get _dao => _db.plansDao;

  // ── Streams ───────────────────────────────────────────────────────

  @override
  Stream<Either<Failure, List<Plan>>> watchPlans() {
    return _dao.watchActivePlans().map(
      (rows) =>
          right<Failure, List<Plan>>(rows.map((r) => r.toEntity()).toList()),
    );
  }

  @override
  Stream<Either<Failure, List<PlanDay>>> watchPlanDays(int planId) {
    return _dao
        .watchPlanDays(planId)
        .map(
          (rows) => right<Failure, List<PlanDay>>(
            rows.map((r) => r.toEntity()).toList(),
          ),
        );
  }

  @override
  Stream<Either<Failure, List<PlanExercise>>> watchAllExercisesForPlan(
    int planId,
  ) {
    return _dao
        .watchAllExercisesForPlan(planId)
        .map(
          (rows) => right<Failure, List<PlanExercise>>(
            rows.map((r) => r.toEntity()).toList(),
          ),
        );
  }

  // ── Plan CRUD ─────────────────────────────────────────────────────

  @override
  TaskEither<Failure, Plan> getPlan(int id) {
    return TaskEither.tryCatch(
      () async {
        final row = await _dao.getPlan(id);
        if (row == null) throw Exception('Plan $id not found');
        return row.toEntity();
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, int> createPlan(String name) {
    return TaskEither.tryCatch(
      () async {
        final now = DateTime.now();
        final sortOrder = await _dao.nextSortOrder();
        return _dao.insertPlan(
          PlansCompanion.insert(
            name: name,
            createdAt: now,
            updatedAt: now,
            sortOrder: Value(sortOrder),
          ),
        );
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, int> duplicatePlan(int planId) {
    return TaskEither.tryCatch(
      () => _db.transaction(() async {
        final original = await _dao.getPlan(planId);
        if (original == null) {
          throw Exception('Plan $planId not found');
        }
        final now = DateTime.now();
        final sortOrder = await _dao.nextSortOrder();
        final newId = await _dao.insertPlan(
          PlansCompanion.insert(
            name: '${original.name} (copy)',
            createdAt: now,
            updatedAt: now,
            sortOrder: Value(sortOrder),
          ),
        );
        final days = await _dao.getPlanDays(planId);
        for (final day in days) {
          final newDayId = await _dao.insertPlanDay(
            PlanDaysCompanion.insert(
              planId: newId,
              orderIndex: day.orderIndex,
              focus: Value(day.focus),
              isRest: Value(day.isRest),
            ),
          );
          final exercises = await _dao.getPlanExercises(day.id);
          for (final ex in exercises) {
            await _dao.insertPlanExercise(
              PlanExercisesCompanion.insert(
                planDayId: newDayId,
                orderIndex: ex.orderIndex,
                name: ex.name,
                equipment: Value(ex.equipment),
                targetSets: Value(ex.targetSets),
                scheme: Value(ex.scheme),
                target: Value(ex.target),
              ),
            );
          }
        }
        return newId;
      }),
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> deletePlan(int planId) {
    return TaskEither.tryCatch(
      () async {
        await _dao.softDeletePlan(planId);
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> setActivePlan(int planId) {
    return TaskEither.tryCatch(
      () async {
        await _dao.setActivePlan(planId);
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> reorderPlans(List<int> orderedPlanIds) {
    return TaskEither.tryCatch(
      () async {
        await _dao.reorderPlans(orderedPlanIds);
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> renamePlan(int planId, String name) {
    return TaskEither.tryCatch(
      () async {
        await _dao.writePlan(
          planId,
          PlansCompanion(
            name: Value(name),
            updatedAt: Value(DateTime.now()),
          ),
        );
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  // ── Day CRUD ──────────────────────────────────────────────────────

  @override
  TaskEither<Failure, int> addDay(
    int planId, {
    required bool isRest,
    String? focus,
  }) {
    return TaskEither.tryCatch(
      () async {
        final existing = await _dao.getPlanDays(planId);
        return _dao.insertPlanDay(
          PlanDaysCompanion.insert(
            planId: planId,
            orderIndex: existing.length,
            isRest: Value(isRest),
            focus: Value(focus),
          ),
        );
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> editDay(PlanDay day) {
    return TaskEither.tryCatch(
      () async {
        await _dao.writePlanDay(
          day.id,
          PlanDaysCompanion(
            planId: Value(day.planId),
            orderIndex: Value(day.orderIndex),
            focus: Value(day.focus),
            isRest: Value(day.isRest),
          ),
        );
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> deleteDay(int dayId) {
    return TaskEither.tryCatch(
      () async {
        await _dao.deletePlanDay(dayId);
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> reorderDays(
    int planId,
    List<int> orderedDayIds,
  ) {
    return TaskEither.tryCatch(
      () async {
        await _dao.reorderDays(planId, orderedDayIds);
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  // ── Exercise CRUD ─────────────────────────────────────────────────

  @override
  TaskEither<Failure, int> addExercise(
    int planDayId, {
    required String name,
    String? equipment,
    int? targetSets,
    String? scheme,
    String? target,
  }) {
    return TaskEither.tryCatch(
      () async {
        final existing = await _dao.getPlanExercises(planDayId);
        return _dao.insertPlanExercise(
          PlanExercisesCompanion.insert(
            planDayId: planDayId,
            orderIndex: existing.length,
            name: name,
            equipment: Value(equipment),
            targetSets: Value(targetSets),
            scheme: Value(scheme),
            target: Value(target),
          ),
        );
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> editExercise(PlanExercise exercise) {
    return TaskEither.tryCatch(
      () async {
        await _dao.writePlanExercise(
          exercise.id,
          PlanExercisesCompanion(
            planDayId: Value(exercise.planDayId),
            orderIndex: Value(exercise.orderIndex),
            name: Value(exercise.name),
            equipment: Value(exercise.equipment),
            targetSets: Value(exercise.targetSets),
            scheme: Value(exercise.scheme),
            target: Value(exercise.target),
          ),
        );
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> deleteExercise(int exerciseId) {
    return TaskEither.tryCatch(
      () async {
        await _dao.deletePlanExercise(exerciseId);
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> reorderExercises(
    int planDayId,
    List<int> orderedExerciseIds,
  ) {
    return TaskEither.tryCatch(
      () async {
        await _dao.reorderExercises(planDayId, orderedExerciseIds);
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }
}
