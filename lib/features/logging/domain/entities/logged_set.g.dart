// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoggedSet _$LoggedSetFromJson(Map<String, dynamic> json) => _LoggedSet(
  id: (json['id'] as num).toInt(),
  sessionExerciseId: (json['sessionExerciseId'] as num).toInt(),
  orderIndex: (json['orderIndex'] as num).toInt(),
  modality: $enumDecode(_$ModalityEnumMap, json['modality']),
  metrics: (json['metrics'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  isDone: json['isDone'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$LoggedSetToJson(_LoggedSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionExerciseId': instance.sessionExerciseId,
      'orderIndex': instance.orderIndex,
      'modality': _$ModalityEnumMap[instance.modality]!,
      'metrics': instance.metrics,
      'isDone': instance.isDone,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$ModalityEnumMap = {
  Modality.strength: 'strength',
  Modality.bodyweight: 'bodyweight',
  Modality.cardio: 'cardio',
  Modality.timed: 'timed',
};
