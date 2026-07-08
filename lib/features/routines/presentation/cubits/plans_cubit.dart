import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/routines/presentation/cubits/plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  PlansCubit({required RoutinesRepository repo})
    : _repo = repo,
      super(const PlansState.initial());

  final RoutinesRepository _repo;
  StreamSubscription<Either<Failure, List<Plan>>>? _sub;

  void init() {
    emit(const PlansState.loading());
    _sub = _repo.watchPlans().listen((result) {
      result.fold(
        (f) => emit(PlansState.error(f.message)),
        (plans) => emit(PlansState.loaded(plans)),
      );
    });
  }

  Future<Either<Failure, int>> createPlan(String name) =>
      _repo.createPlan(name).run();

  Future<Either<Failure, int>> duplicatePlan(int planId) =>
      _repo.duplicatePlan(planId).run();

  Future<Either<Failure, Unit>> deletePlan(int planId) =>
      _repo.deletePlan(planId).run();

  Future<Either<Failure, Unit>> setActivePlan(int planId) =>
      _repo.setActivePlan(planId).run();

  Future<Either<Failure, Unit>> reorderPlans(List<int> orderedIds) =>
      _repo.reorderPlans(orderedIds).run();

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
