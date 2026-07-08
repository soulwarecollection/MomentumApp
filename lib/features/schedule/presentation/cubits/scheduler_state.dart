import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';

part 'scheduler_state.freezed.dart';

@freezed
sealed class SchedulerState with _$SchedulerState {
  const factory SchedulerState.loading() = SchedulerLoading;
  const factory SchedulerState.ready({
    required List<Plan> plans,
    required int selectedPlanId,
    required List<PlanDay> selectedPlanDays,
    required int selectedDayIndex,
    DateTime? scheduledDate,
  }) = SchedulerReady;
  const factory SchedulerState.error(String message) = SchedulerError;
}
