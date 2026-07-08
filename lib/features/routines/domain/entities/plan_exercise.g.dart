// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanExercise _$PlanExerciseFromJson(Map<String, dynamic> json) =>
    _PlanExercise(
      id: (json['id'] as num).toInt(),
      planDayId: (json['planDayId'] as num).toInt(),
      orderIndex: (json['orderIndex'] as num).toInt(),
      name: json['name'] as String,
      equipment: json['equipment'] as String?,
      targetSets: (json['targetSets'] as num?)?.toInt(),
      scheme: json['scheme'] as String?,
      target: json['target'] as String?,
    );

Map<String, dynamic> _$PlanExerciseToJson(_PlanExercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'planDayId': instance.planDayId,
      'orderIndex': instance.orderIndex,
      'name': instance.name,
      'equipment': instance.equipment,
      'targetSets': instance.targetSets,
      'scheme': instance.scheme,
      'target': instance.target,
    };
