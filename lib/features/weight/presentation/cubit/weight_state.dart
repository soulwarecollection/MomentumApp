import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/core/db/app_database.dart';

part 'weight_state.freezed.dart';

@freezed
sealed class WeightState with _$WeightState {
  const factory WeightState.loading() = WeightLoading;
  const factory WeightState.ready({
    required List<WeightEntryRow> entries,
    required List<WeightEntryRow> chartPoints,
    WeightEntryRow? latest,
  }) = WeightReady;
  const factory WeightState.error(String message) = WeightError;
}
