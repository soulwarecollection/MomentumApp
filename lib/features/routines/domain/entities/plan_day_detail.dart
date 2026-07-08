import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';

part 'plan_day_detail.freezed.dart';

/// A `PlanDay` combined with its ordered list of exercises.
/// Used exclusively in presentation state — not persisted.
@freezed
sealed class PlanDayDetail with _$PlanDayDetail {
  const factory PlanDayDetail({
    required PlanDay day,
    required List<PlanExercise> exercises,
  }) = _PlanDayDetail;
}
