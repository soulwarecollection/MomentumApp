import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/features/progress/domain/entities/session_exercise_detail.dart';
import 'package:momentum/features/progress/domain/entities/session_summary.dart';

part 'session_detail_state.freezed.dart';

@freezed
sealed class SessionDetailState with _$SessionDetailState {
  const factory SessionDetailState.loading() = SessionDetailLoading;

  const factory SessionDetailState.ready({
    required SessionSummary summary,
    required List<SessionExerciseDetail> exercises,
  }) = SessionDetailReady;

  const factory SessionDetailState.error(String message) = SessionDetailError;
}
