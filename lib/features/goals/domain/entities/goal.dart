import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/core/enums/goal_type.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

@freezed
sealed class Goal with _$Goal {
  const factory Goal({
    required int id,
    required GoalType type,
    required double targetValue,
    required DateTime deadline,
    required DateTime createdAt,
    double? startValue,
    String? exerciseName,
  }) = _Goal;

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
}
