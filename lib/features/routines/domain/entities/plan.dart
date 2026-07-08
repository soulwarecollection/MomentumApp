import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan.freezed.dart';
part 'plan.g.dart';

@freezed
sealed class Plan with _$Plan {
  const factory Plan({
    required int id,
    required String name,
    required bool isActive,
    required int currentDayIndex,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}
