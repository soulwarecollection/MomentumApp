import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day_detail.dart';

part 'plan_editor_state.freezed.dart';

@freezed
sealed class PlanEditorState with _$PlanEditorState {
  const factory PlanEditorState.initial() = PlanEditorInitial;
  const factory PlanEditorState.loading() = PlanEditorLoading;
  const factory PlanEditorState.loaded({
    required Plan plan,
    required List<PlanDayDetail> days,
  }) = PlanEditorLoaded;
  const factory PlanEditorState.error(String message) = PlanEditorError;
}
