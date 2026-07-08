// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanDay _$PlanDayFromJson(Map<String, dynamic> json) => _PlanDay(
  id: (json['id'] as num).toInt(),
  planId: (json['planId'] as num).toInt(),
  orderIndex: (json['orderIndex'] as num).toInt(),
  isRest: json['isRest'] as bool,
  focus: json['focus'] as String?,
);

Map<String, dynamic> _$PlanDayToJson(_PlanDay instance) => <String, dynamic>{
  'id': instance.id,
  'planId': instance.planId,
  'orderIndex': instance.orderIndex,
  'isRest': instance.isRest,
  'focus': instance.focus,
};
