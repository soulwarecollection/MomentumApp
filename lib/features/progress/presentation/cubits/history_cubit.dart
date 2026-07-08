import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/features/progress/domain/entities/session_summary.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';
import 'package:momentum/features/progress/domain/usecases/compute_consistency_heatmap.dart';
import 'package:momentum/features/progress/presentation/cubits/history_state.dart';

@injectable
class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this._repo) : super(const HistoryState.loading());

  final ProgressRepository _repo;

  static const _heatmap = ComputeConsistencyHeatmap();

  List<DateTime>? _dates;
  List<SessionSummary>? _sessions;
  StreamSubscription<dynamic>? _datesSub;
  StreamSubscription<dynamic>? _sessionsSub;

  Future<void> load() async {
    await _datesSub?.cancel();
    await _sessionsSub?.cancel();
    _dates = null;
    _sessions = null;
    emit(const HistoryState.loading());

    _datesSub = _repo.watchSessionDates().listen(
      (result) => result.fold(
        (f) => emit(HistoryState.error(f.message)),
        (dates) {
          _dates = dates;
          _rebuild();
        },
      ),
      onError: (Object e) => emit(HistoryState.error(e.toString())),
    );

    _sessionsSub = _repo.watchSessionSummaries().listen(
      (result) => result.fold(
        (f) => emit(HistoryState.error(f.message)),
        (sessions) {
          _sessions = sessions;
          _rebuild();
        },
      ),
      onError: (Object e) => emit(HistoryState.error(e.toString())),
    );
  }

  void _rebuild() {
    final dates = _dates;
    final sessions = _sessions;
    if (dates == null || sessions == null) return;
    emit(
      HistoryState.ready(
        heatmap: _heatmap(dates),
        sessions: sessions,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _datesSub?.cancel();
    await _sessionsSub?.cancel();
    return super.close();
  }
}
