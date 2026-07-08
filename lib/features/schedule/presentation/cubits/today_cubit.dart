import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/schedule/domain/entities/next_workout.dart';
import 'package:momentum/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:momentum/features/schedule/presentation/cubits/today_state.dart';

class TodayCubit extends Cubit<TodayState> {
  TodayCubit({
    required RoutinesRepository routinesRepo,
    required ScheduleRepository scheduleRepo,
  }) : _routinesRepo = routinesRepo,
       _scheduleRepo = scheduleRepo,
       super(const TodayState.loading());

  final RoutinesRepository _routinesRepo;
  final ScheduleRepository _scheduleRepo;

  List<Plan>? _plans;
  List<PlanDay>? _days;
  List<PlanExercise>? _exercises;
  int? _trackedPlanId;

  StreamSubscription<dynamic>? _plansSub;
  StreamSubscription<dynamic>? _daysSub;
  StreamSubscription<dynamic>? _exSub;
  StreamSubscription<void>? _overrideSub;

  void init() {
    _plansSub = _routinesRepo.watchPlans().listen((result) {
      result.fold(
        (f) => emit(TodayState.error(f.message)),
        _onPlansChanged,
      );
    });
    _overrideSub = _scheduleRepo.overrideChanges.listen((_) {
      if (_plans != null) _onPlansChanged(_plans!);
    });
  }

  void _onPlansChanged(List<Plan> plans) {
    _plans = plans;
    if (plans.isEmpty) {
      emit(const TodayState.noActivePlan());
      return;
    }
    final override = _scheduleRepo.getOverride();
    final effectivePlanId = override?.planId ?? _activePlanId(plans);
    if (effectivePlanId == null) {
      emit(const TodayState.noActivePlan());
      return;
    }
    if (effectivePlanId != _trackedPlanId) {
      _trackedPlanId = effectivePlanId;
      _days = null;
      _exercises = null;
      unawaited(_restartDetailSubs(effectivePlanId));
    } else {
      _rebuild();
    }
  }

  Future<void> _restartDetailSubs(int planId) async {
    await _daysSub?.cancel();
    await _exSub?.cancel();
    _daysSub = _routinesRepo.watchPlanDays(planId).listen((result) {
      result.fold(
        (f) => emit(TodayState.error(f.message)),
        (days) {
          _days = days;
          _rebuild();
        },
      );
    });
    _exSub = _routinesRepo.watchAllExercisesForPlan(planId).listen((result) {
      result.fold(
        (f) => emit(TodayState.error(f.message)),
        (exs) {
          _exercises = exs;
          _rebuild();
        },
      );
    });
  }

  void _rebuild() {
    final plans = _plans;
    final days = _days;
    final exercises = _exercises;
    if (plans == null || days == null || exercises == null) return;
    if (days.isEmpty) {
      emit(const TodayState.noActivePlan());
      return;
    }

    final override = _scheduleRepo.getOverride();
    final effectivePlanId = override?.planId ?? _activePlanId(plans);
    if (effectivePlanId == null) {
      emit(const TodayState.noActivePlan());
      return;
    }

    Plan? plan;
    for (final p in plans) {
      if (p.id == effectivePlanId) {
        plan = p;
        break;
      }
    }
    if (plan == null) {
      emit(const TodayState.noActivePlan());
      return;
    }

    final dayIndex = override?.dayIndex ?? plan.currentDayIndex;
    final clamped = dayIndex.clamp(0, days.length - 1);
    final day = days[clamped];
    final dayExercises = exercises.where((e) => e.planDayId == day.id).toList();

    emit(
      TodayState.ready(
        nextWorkout: NextWorkout(
          plan: plan,
          dayIndex: clamped,
          day: day,
          exercises: dayExercises,
          scheduledDate: override?.scheduledDate,
        ),
        allDays: days,
      ),
    );
  }

  Future<void> setNextDay(int dayIndex) async {
    final planId = _trackedPlanId;
    if (planId == null) return;
    final existing = _scheduleRepo.getOverride();
    await _scheduleRepo.setOverride(
      planId: planId,
      dayIndex: dayIndex,
      scheduledDate: existing?.scheduledDate,
    );
  }

  int? _activePlanId(List<Plan> plans) {
    for (final p in plans) {
      if (p.isActive) return p.id;
    }
    return plans.isEmpty ? null : plans.first.id;
  }

  @override
  Future<void> close() async {
    await _plansSub?.cancel();
    await _daysSub?.cancel();
    await _exSub?.cancel();
    await _overrideSub?.cancel();
    return super.close();
  }
}
