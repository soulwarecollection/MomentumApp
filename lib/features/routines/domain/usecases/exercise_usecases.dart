import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';

@injectable
class AddExerciseUseCase {
  const AddExerciseUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, int> call(
    int planDayId, {
    required String name,
    String? equipment,
    int? targetSets,
    String? scheme,
    String? target,
  }) => _repo.addExercise(
    planDayId,
    name: name,
    equipment: equipment,
    targetSets: targetSets,
    scheme: scheme,
    target: target,
  );
}

@injectable
class EditExerciseUseCase {
  const EditExerciseUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, Unit> call(PlanExercise exercise) =>
      _repo.editExercise(exercise);
}

@injectable
class DeleteExerciseUseCase {
  const DeleteExerciseUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, Unit> call(int exerciseId) =>
      _repo.deleteExercise(exerciseId);
}

@injectable
class ReorderExercisesUseCase {
  const ReorderExercisesUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, Unit> call(
    int planDayId,
    List<int> orderedExerciseIds,
  ) => _repo.reorderExercises(planDayId, orderedExerciseIds);
}
