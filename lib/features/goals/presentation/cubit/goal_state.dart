import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/features/goals/domain/entities/goal_progress.dart';

part 'goal_state.freezed.dart';

@freezed
sealed class GoalState with _$GoalState {
  const factory GoalState.loading() = GoalLoading;
  const factory GoalState.noGoal() = GoalNoGoal;
  const factory GoalState.active(GoalProgress progress) = GoalActive;
  const factory GoalState.error(String message) = GoalError;
}
