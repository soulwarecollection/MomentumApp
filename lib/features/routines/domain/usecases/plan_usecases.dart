import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';

@injectable
class WatchPlansUseCase {
  const WatchPlansUseCase(this._repo);
  final RoutinesRepository _repo;
  Stream<Either<Failure, List<Plan>>> call() => _repo.watchPlans();
}

@injectable
class CreatePlanUseCase {
  const CreatePlanUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, int> call(String name) => _repo.createPlan(name);
}

@injectable
class DuplicatePlanUseCase {
  const DuplicatePlanUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, int> call(int planId) => _repo.duplicatePlan(planId);
}

@injectable
class DeletePlanUseCase {
  const DeletePlanUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, Unit> call(int planId) => _repo.deletePlan(planId);
}

@injectable
class SetActivePlanUseCase {
  const SetActivePlanUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, Unit> call(int planId) => _repo.setActivePlan(planId);
}

@injectable
class RenamePlanUseCase {
  const RenamePlanUseCase(this._repo);
  final RoutinesRepository _repo;
  TaskEither<Failure, Unit> call(int planId, String name) =>
      _repo.renamePlan(planId, name);
}
