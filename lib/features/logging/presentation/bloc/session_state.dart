import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/features/logging/domain/entities/exercise_entry.dart';

part 'session_state.freezed.dart';

@freezed
sealed class SessionState with _$SessionState {
  const factory SessionState.idle() = SessionIdle;

  const factory SessionState.active({
    required int sessionId,
    required List<ExerciseEntry> exercises,
    @Default(false) bool stopwatchRunning,
    @Default(0) int totalPausedMs,
    DateTime? stopwatchStartedAt,
    DateTime? stopwatchPausedAt,
    int? restSecondsLeft,
    int? restSecondsTotal,
    String? celebrationExercise,
    String? focus,
    int? planId,
    int? dayIndex,
    int? planTotalDays,
  }) = SessionActive;

  const factory SessionState.saving() = SessionSaving;

  const factory SessionState.finished() = SessionFinished;

  const factory SessionState.error(String message) = SessionError;
}
