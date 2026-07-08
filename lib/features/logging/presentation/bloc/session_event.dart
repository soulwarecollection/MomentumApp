import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/core/enums/equipment_type.dart';
import 'package:momentum/features/logging/domain/entities/exercise_entry.dart';

part 'session_event.freezed.dart';

@freezed
sealed class SessionEvent with _$SessionEvent {
  const factory SessionEvent.started({
    required List<ExerciseEntry> exercises,
    int? planId,
    int? dayIndex,
    int? planTotalDays,
    String? focus,
  }) = SessionStarted;

  const factory SessionEvent.exercisePreFilled({
    required String exerciseLocalId,
    required List<Map<String, double>> setMetrics,
  }) = ExercisePreFilled;

  const factory SessionEvent.setRowValue({
    required String exerciseLocalId,
    required String setLocalId,
    required String metricKey,
    required double value,
  }) = SetRowValue;

  const factory SessionEvent.stepRowValue({
    required String exerciseLocalId,
    required String setLocalId,
    required String metricKey,
    required double delta,
  }) = StepRowValue;

  const factory SessionEvent.rowToggled({
    required String exerciseLocalId,
    required String setLocalId,
  }) = RowToggled;

  const factory SessionEvent.setAdded(String exerciseLocalId) = SetAdded;

  const factory SessionEvent.setRemoved({
    required String exerciseLocalId,
    required String setLocalId,
  }) = SetRemoved;

  const factory SessionEvent.exerciseReordered({
    required int oldIndex,
    required int newIndex,
  }) = ExerciseReordered;

  const factory SessionEvent.exerciseToggled(
    String exerciseLocalId,
  ) = ExerciseToggled;

  const factory SessionEvent.adhocExerciseAdded(
    ExerciseEntry exercise,
  ) = AdhocExerciseAdded;

  const factory SessionEvent.stopwatchToggled() = StopwatchToggled;

  const factory SessionEvent.restTimerStarted(int seconds) = RestTimerStarted;

  const factory SessionEvent.restTimerAdjusted(int delta) = RestTimerAdjusted;

  const factory SessionEvent.restTimerTicked() = RestTimerTicked;

  const factory SessionEvent.restTimerSkipped() = RestTimerSkipped;

  const factory SessionEvent.setRowExpanded({
    required String exerciseLocalId,
    required String setLocalId,
    required bool expanded,
  }) = SetRowExpanded;

  const factory SessionEvent.exerciseEquipmentChanged({
    required String exerciseLocalId,
    required EquipmentType? equipment,
  }) = ExerciseEquipmentChanged;

  const factory SessionEvent.exerciseNoteChanged({
    required String exerciseLocalId,
    required String? note,
  }) = ExerciseNoteChanged;

  const factory SessionEvent.exerciseTargetChanged({
    required String exerciseLocalId,
    required double? targetWeight,
  }) = ExerciseTargetChanged;

  const factory SessionEvent.celebrationDismissed() = CelebrationDismissed;

  const factory SessionEvent.finishRequested() = FinishRequested;
}
