import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:momentum/features/schedule/presentation/cubits/scheduler_state.dart';

class SchedulerCubit extends Cubit<SchedulerState> {
  SchedulerCubit({
    required RoutinesRepository routinesRepo,
    required ScheduleRepository scheduleRepo,
  }) : _routinesRepo = routinesRepo,
       _scheduleRepo = scheduleRepo,
       super(const SchedulerState.loading());

  final RoutinesRepository _routinesRepo;
  final ScheduleRepository _scheduleRepo;

  Future<void> init() async {
    final plansResult = await _routinesRepo.watchPlans().first;
    final plans = plansResult.fold((_) => null, (p) => p);
    if (plans == null || plans.isEmpty) {
      emit(const SchedulerState.error('No plans found'));
      return;
    }

    final override = _scheduleRepo.getOverride();

    Plan? selectedPlan;
    if (override != null) {
      for (final p in plans) {
        if (p.id == override.planId) {
          selectedPlan = p;
          break;
        }
      }
    }
    selectedPlan ??= plans.firstWhere(
      (p) => p.isActive,
      orElse: () => plans.first,
    );

    final initialDayIndex = (override?.planId == selectedPlan.id)
        ? (override?.dayIndex ?? selectedPlan.currentDayIndex)
        : selectedPlan.currentDayIndex;

    final daysResult = await _routinesRepo.watchPlanDays(selectedPlan.id).first;
    daysResult.fold(
      (f) => emit(SchedulerState.error(f.message)),
      (days) {
        final clamped = days.isEmpty
            ? 0
            : initialDayIndex.clamp(0, days.length - 1);
        emit(
          SchedulerState.ready(
            plans: plans,
            selectedPlanId: selectedPlan!.id,
            selectedPlanDays: days,
            selectedDayIndex: clamped,
            scheduledDate: override?.scheduledDate,
          ),
        );
      },
    );
  }

  Future<void> changePlan(int planId) async {
    final s = state;
    if (s is! SchedulerReady) return;

    Plan? plan;
    for (final p in s.plans) {
      if (p.id == planId) {
        plan = p;
        break;
      }
    }
    if (plan == null) return;

    final daysResult = await _routinesRepo.watchPlanDays(planId).first;
    daysResult.fold(
      (f) => emit(SchedulerState.error(f.message)),
      (days) {
        final clamped = days.isEmpty
            ? 0
            : plan!.currentDayIndex.clamp(0, days.length - 1);
        emit(
          s.copyWith(
            selectedPlanId: planId,
            selectedPlanDays: days,
            selectedDayIndex: clamped,
          ),
        );
      },
    );
  }

  void changeDay(int dayIndex) {
    final s = state;
    if (s is! SchedulerReady) return;
    emit(s.copyWith(selectedDayIndex: dayIndex));
  }

  void changeDate(DateTime? date) {
    final s = state;
    if (s is! SchedulerReady) return;
    emit(s.copyWith(scheduledDate: date));
  }

  Future<void> save() async {
    final s = state;
    if (s is! SchedulerReady) return;
    await _scheduleRepo.setOverride(
      planId: s.selectedPlanId,
      dayIndex: s.selectedDayIndex,
      scheduledDate: s.scheduledDate,
    );
  }
}
