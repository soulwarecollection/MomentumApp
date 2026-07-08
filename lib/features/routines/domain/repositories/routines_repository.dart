import 'package:fpdart/fpdart.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';

abstract class RoutinesRepository {
  // ── Reactive streams ──────────────────────────────────────────────

  Stream<Either<Failure, List<Plan>>> watchPlans();

  Stream<Either<Failure, List<PlanDay>>> watchPlanDays(int planId);

  Stream<Either<Failure, List<PlanExercise>>> watchAllExercisesForPlan(
    int planId,
  );

  // ── Plan CRUD ─────────────────────────────────────────────────────

  TaskEither<Failure, Plan> getPlan(int id);

  TaskEither<Failure, int> createPlan(String name);

  TaskEither<Failure, int> duplicatePlan(int planId);

  TaskEither<Failure, Unit> deletePlan(int planId);

  TaskEither<Failure, Unit> setActivePlan(int planId);

  TaskEither<Failure, Unit> renamePlan(int planId, String name);

  TaskEither<Failure, Unit> reorderPlans(List<int> orderedPlanIds);

  // ── Day CRUD ──────────────────────────────────────────────────────

  TaskEither<Failure, int> addDay(
    int planId, {
    required bool isRest,
    String? focus,
  });

  TaskEither<Failure, Unit> editDay(PlanDay day);

  TaskEither<Failure, Unit> deleteDay(int dayId);

  TaskEither<Failure, Unit> reorderDays(
    int planId,
    List<int> orderedDayIds,
  );

  // ── Exercise CRUD ─────────────────────────────────────────────────

  TaskEither<Failure, int> addExercise(
    int planDayId, {
    required String name,
    String? equipment,
    int? targetSets,
    String? scheme,
    String? target,
  });

  TaskEither<Failure, Unit> editExercise(PlanExercise exercise);

  TaskEither<Failure, Unit> deleteExercise(int exerciseId);

  TaskEither<Failure, Unit> reorderExercises(
    int planDayId,
    List<int> orderedExerciseIds,
  );
}
