// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Goal _$GoalFromJson(Map<String, dynamic> json) => _Goal(
  id: (json['id'] as num).toInt(),
  type: $enumDecode(_$GoalTypeEnumMap, json['type']),
  targetValue: (json['targetValue'] as num).toDouble(),
  deadline: DateTime.parse(json['deadline'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  startValue: (json['startValue'] as num?)?.toDouble(),
  exerciseName: json['exerciseName'] as String?,
);

Map<String, dynamic> _$GoalToJson(_Goal instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$GoalTypeEnumMap[instance.type]!,
  'targetValue': instance.targetValue,
  'deadline': instance.deadline.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'startValue': instance.startValue,
  'exerciseName': instance.exerciseName,
};

const _$GoalTypeEnumMap = {
  GoalType.fatLoss: 'fatLoss',
  GoalType.weightGain: 'weightGain',
  GoalType.strengthPr: 'strengthPr',
};
