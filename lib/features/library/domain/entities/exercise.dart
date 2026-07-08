import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/core/enums/modality.dart';

part 'exercise.freezed.dart';

@freezed
sealed class Exercise with _$Exercise {
  const factory Exercise({
    required int id,
    required String name,
    required Modality modality,
    String? muscleGroup,
    String? equipment,
    @Default(false) bool isCustom,
  }) = _Exercise;
}
