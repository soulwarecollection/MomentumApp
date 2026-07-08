import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_day_detail.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/routines/presentation/cubits/plan_editor_state.dart';

class PlanEditorCubit extends Cubit<PlanEditorState> {
  PlanEditorCubit({
    required RoutinesRepository repo,
    required int planId,
  }) : _repo = repo,
       _planId = planId,
       super(const PlanEditorState.loading());

  final RoutinesRepository _repo;
  final int _planId;

  Plan? _plan;
  List<PlanDay>? _latestDays;
  List<PlanExercise>? _latestExercises;

  StreamSubscription<Either<Failure, List<PlanDay>>>? _daysSub;
  StreamSubscription<Either<Failure, List<PlanExercise>>>? _exSub;

  Future<void> init() async {
    final result = await _repo.getPlan(_planId).run();
    result.fold(
      (f) => emit(PlanEditorState.error(f.message)),
      (plan) {
        _plan = plan;
        _startStreams();
      },
    );
  }

  void _startStreams() {
    _daysSub = _repo.watchPlanDays(_planId).listen((result) {
      result.fold(
        (f) => emit(PlanEditorState.error(f.message)),
        (days) {
          _latestDays = days;
          _rebuild();
        },
      );
    });

    _exSub = _repo.watchAllExercisesForPlan(_planId).listen((result) {
      result.fold(
        (f) => emit(PlanEditorState.error(f.message)),
        (exercises) {
          _latestExercises = exercises;
          _rebuild();
        },
      );
    });
  }

  void _rebuild() {
    final days = _latestDays;
    final exercises = _latestExercises;
    final plan = _plan;
    if (days == null || exercises == null || plan == null) return;

    final byDay = <int, List<PlanExercise>>{};
    for (final ex in exercises) {
      (byDay[ex.planDayId] ??= []).add(ex);
    }

    final details = days
        .map(
          (d) => PlanDayDetail(day: d, exercises: byDay[d.id] ?? []),
        )
        .toList();

    emit(PlanEditorState.loaded(plan: plan, days: details));
  }

  // ── Plan mutations ────────────────────────────────────────────────

  Future<Either<Failure, Unit>> renamePlan(String name) async {
    final result = await _repo.renamePlan(_planId, name).run();
    result.fold(
      (_) {},
      (_) => _plan = _plan?.copyWith(name: name),
    );
    _rebuild();
    return result;
  }

  Future<Either<Failure, Unit>> setActive() =>
      _repo.setActivePlan(_planId).run();

  // ── Day mutations ─────────────────────────────────────────────────

  Future<Either<Failure, int>> addDay({
    required bool isRest,
    String? focus,
  }) => _repo.addDay(_planId, isRest: isRest, focus: focus).run();

  Future<Either<Failure, Unit>> editDay(PlanDay day) =>
      _repo.editDay(day).run();

  Future<Either<Failure, Unit>> deleteDay(int dayId) =>
      _repo.deleteDay(dayId).run();

  Future<Either<Failure, Unit>> reorderDays(
    List<int> orderedDayIds,
  ) => _repo.reorderDays(_planId, orderedDayIds).run();

  // ── Exercise mutations ────────────────────────────────────────────

  Future<Either<Failure, int>> addExercise(
    int planDayId, {
    required String name,
    String? equipment,
    int? targetSets,
    String? scheme,
    String? target,
  }) => _repo
      .addExercise(
        planDayId,
        name: name,
        equipment: equipment,
        targetSets: targetSets,
        scheme: scheme,
        target: target,
      )
      .run();

  Future<Either<Failure, Unit>> editExercise(PlanExercise exercise) =>
      _repo.editExercise(exercise).run();

  Future<Either<Failure, Unit>> deleteExercise(int exerciseId) =>
      _repo.deleteExercise(exerciseId).run();

  Future<Either<Failure, Unit>> reorderExercises(
    int planDayId,
    List<int> orderedIds,
  ) => _repo.reorderExercises(planDayId, orderedIds).run();

  @override
  Future<void> close() async {
    await _daysSub?.cancel();
    await _exSub?.cancel();
    return super.close();
  }
}
