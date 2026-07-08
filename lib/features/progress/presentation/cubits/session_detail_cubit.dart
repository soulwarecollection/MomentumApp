import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/progress/domain/entities/session_summary.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';
import 'package:momentum/features/progress/presentation/cubits/session_detail_state.dart';

@injectable
class SessionDetailCubit extends Cubit<SessionDetailState> {
  SessionDetailCubit(this._repo) : super(const SessionDetailState.loading());

  final ProgressRepository _repo;

  Future<void> load(int sessionId) async {
    emit(const SessionDetailState.loading());

    SessionSummary? summary;
    final summaryResult = await _repo.getSessionSummary(sessionId).run();
    summaryResult.fold(_onError, (s) => summary = s);
    if (summary == null) return;

    final exResult = await _repo.getSessionExercises(sessionId).run();
    exResult.fold(
      _onError,
      (exercises) => emit(
        SessionDetailState.ready(summary: summary!, exercises: exercises),
      ),
    );
  }

  void _onError(Failure failure) =>
      emit(SessionDetailState.error(failure.message));
}
