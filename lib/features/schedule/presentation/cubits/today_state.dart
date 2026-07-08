import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/schedule/domain/entities/next_workout.dart';

part 'today_state.freezed.dart';

@freezed
sealed class TodayState with _$TodayState {
  const factory TodayState.loading() = TodayLoading;
  const factory TodayState.noActivePlan() = TodayNoActivePlan;
  const factory TodayState.ready({
    required NextWorkout nextWorkout,
    required List<PlanDay> allDays,
  }) = TodayReady;
  const factory TodayState.error(String message) = TodayError;
}
