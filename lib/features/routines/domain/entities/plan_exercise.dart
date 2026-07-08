import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_exercise.freezed.dart';
part 'plan_exercise.g.dart';

@freezed
sealed class PlanExercise with _$PlanExercise {
  const factory PlanExercise({
    required int id,
    required int planDayId,
    required int orderIndex,
    required String name,
    String? equipment,

    /// Number of target sets per session.
    int? targetSets,

    /// Prescription shorthand, e.g. "3×8", "5-5-5+", "AMRAP".
    String? scheme,

    /// Load target, e.g. "75 kg", "80 % 1RM", "bodyweight".
    String? target,
  }) = _PlanExercise;

  factory PlanExercise.fromJson(Map<String, dynamic> json) =>
      _$PlanExerciseFromJson(json);
}
