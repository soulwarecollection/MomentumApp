import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/core/enums/modality.dart';

part 'logged_set.freezed.dart';
part 'logged_set.g.dart';

@freezed
sealed class LoggedSet with _$LoggedSet {
  const factory LoggedSet({
    required int id,
    required int sessionExerciseId,
    required int orderIndex,
    required Modality modality,
    required Map<String, double> metrics,
    required bool isDone,
    required DateTime createdAt,
  }) = _LoggedSet;

  factory LoggedSet.fromJson(Map<String, dynamic> json) =>
      _$LoggedSetFromJson(json);
}
