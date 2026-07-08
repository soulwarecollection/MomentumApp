// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionExercise _$SessionExerciseFromJson(Map<String, dynamic> json) =>
    _SessionExercise(
      id: (json['id'] as num).toInt(),
      sessionId: (json['sessionId'] as num).toInt(),
      orderIndex: (json['orderIndex'] as num).toInt(),
      name: json['name'] as String,
      modality: $enumDecode(_$ModalityEnumMap, json['modality']),
      equipment: json['equipment'] as String?,
    );

Map<String, dynamic> _$SessionExerciseToJson(_SessionExercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'orderIndex': instance.orderIndex,
      'name': instance.name,
      'modality': _$ModalityEnumMap[instance.modality]!,
      'equipment': instance.equipment,
    };

const _$ModalityEnumMap = {
  Modality.strength: 'strength',
  Modality.bodyweight: 'bodyweight',
  Modality.cardio: 'cardio',
  Modality.timed: 'timed',
};
