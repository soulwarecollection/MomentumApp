import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/core/enums/equipment_type.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/logging/domain/entities/set_row.dart';

part 'exercise_entry.freezed.dart';

@freezed
sealed class ExerciseEntry with _$ExerciseEntry {
  const factory ExerciseEntry({
    required String localId,
    required String name,
    required Modality modality,
    required List<SetRow> sets,
    @Default(false) bool isCollapsed,
    @Default(false) bool isPrHighlighted,
    EquipmentType? equipment,
    String? exerciseNote,
    double? targetWeight,
  }) = _ExerciseEntry;
}
