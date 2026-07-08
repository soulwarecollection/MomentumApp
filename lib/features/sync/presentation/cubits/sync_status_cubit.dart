import 'package:flutter_bloc/flutter_bloc.dart';

sealed class SyncStatusState {
  const SyncStatusState();
}

class SyncIdle extends SyncStatusState {
  const SyncIdle();
}

class SyncInProgress extends SyncStatusState {
  const SyncInProgress();
}

class SyncDone extends SyncStatusState {
  const SyncDone({required this.lastSync});
  final DateTime lastSync;
}

class SyncError extends SyncStatusState {
  const SyncError({required this.message});
  final String message;
}

class SyncStatusCubit extends Cubit<SyncStatusState> {
  SyncStatusCubit() : super(const SyncIdle());

  void onSyncStarted() => emit(const SyncInProgress());

  void onSyncDone() => emit(SyncDone(lastSync: DateTime.now()));

  void onSyncError(String message) => emit(SyncError(message: message));
}
