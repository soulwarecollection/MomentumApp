import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';

@injectable
class AddDayUseCase {
  const AddDayUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, int> call(
    int planId, {
    required bool isRest,
    String? focus,
  }) => _repo.addDay(planId, isRest: isRest, focus: focus);
}

@injectable
class EditDayUseCase {
  const EditDayUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, Unit> call(PlanDay day) => _repo.editDay(day);
}

@injectable
class DeleteDayUseCase {
  const DeleteDayUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, Unit> call(int dayId) => _repo.deleteDay(dayId);
}

@injectable
class ReorderDaysUseCase {
  const ReorderDaysUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, Unit> call(
    int planId,
    List<int> orderedDayIds,
  ) => _repo.reorderDays(planId, orderedDayIds);
}
