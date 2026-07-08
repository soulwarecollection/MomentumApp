// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Session _$SessionFromJson(Map<String, dynamic> json) => _Session(
  id: (json['id'] as num).toInt(),
  startedAt: DateTime.parse(json['startedAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  planId: (json['planId'] as num?)?.toInt(),
  dayIndex: (json['dayIndex'] as num?)?.toInt(),
  focus: json['focus'] as String?,
  endedAt: json['endedAt'] == null
      ? null
      : DateTime.parse(json['endedAt'] as String),
  durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
  note: json['note'] as String?,
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$SessionToJson(_Session instance) => <String, dynamic>{
  'id': instance.id,
  'startedAt': instance.startedAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'planId': instance.planId,
  'dayIndex': instance.dayIndex,
  'focus': instance.focus,
  'endedAt': instance.endedAt?.toIso8601String(),
  'durationSeconds': instance.durationSeconds,
  'note': instance.note,
  'deletedAt': instance.deletedAt?.toIso8601String(),
};
