import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/progress/domain/entities/orm_data_point.dart';
import 'package:momentum/features/progress/domain/entities/pr_record.dart';
import 'package:momentum/features/progress/domain/enums/date_range.dart';

part 'progress_state.freezed.dart';

@freezed
sealed class ProgressState with _$ProgressState {
  const factory ProgressState.loading() = ProgressLoading;

  const factory ProgressState.empty() = ProgressEmpty;

  const factory ProgressState.ready({
    required String focusExercise,
    required double estimated1rm,
    required List<double> ormSparkValues,
    required double weekVolumeKg,
    required List<double> volumeSparkValues,
    required List<OrmDataPoint> allTrendPoints,
    required List<OrmDataPoint> filteredTrendPoints,
    required Map<Modality, double> volumeDistribution,
    required List<PrRecord> prRecords,
    required DateRange selectedRange,
  }) = ProgressReady;

  const factory ProgressState.error(String message) = ProgressError;
}
