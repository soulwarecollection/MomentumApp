import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/features/progress/domain/entities/heatmap_cell.dart';
import 'package:momentum/features/progress/domain/entities/session_summary.dart';

part 'history_state.freezed.dart';

@freezed
sealed class HistoryState with _$HistoryState {
  const factory HistoryState.loading() = HistoryLoading;

  const factory HistoryState.ready({
    required List<HeatmapCell> heatmap,
    required List<SessionSummary> sessions,
  }) = HistoryReady;

  const factory HistoryState.error(String message) = HistoryError;
}
