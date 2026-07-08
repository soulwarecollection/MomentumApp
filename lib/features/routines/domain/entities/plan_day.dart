import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_day.freezed.dart';
part 'plan_day.g.dart';

@freezed
sealed class PlanDay with _$PlanDay {
  const factory PlanDay({
    required int id,
    required int planId,
    required int orderIndex,
    required bool isRest,
    String? focus,
  }) = _PlanDay;

  factory PlanDay.fromJson(Map<String, dynamic> json) =>
      _$PlanDayFromJson(json);
}
