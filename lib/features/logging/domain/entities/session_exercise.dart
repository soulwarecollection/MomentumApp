import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/core/enums/modality.dart';

part 'session_exercise.freezed.dart';
part 'session_exercise.g.dart';

@freezed
sealed class SessionExercise with _$SessionExercise {
  const factory SessionExercise({
    required int id,
    required int sessionId,
    required int orderIndex,
    required String name,
    required Modality modality,
    String? equipment,
  }) = _SessionExercise;

  factory SessionExercise.fromJson(Map<String, dynamic> json) =>
      _$SessionExerciseFromJson(json);
}
