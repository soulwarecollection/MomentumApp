import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_row.freezed.dart';

@freezed
sealed class SetRow with _$SetRow {
  const factory SetRow({
    required String localId,
    required Map<String, double> metrics,
    @Default(false) bool isDone,
    @Default(false) bool isExpanded,
  }) = _SetRow;
}
