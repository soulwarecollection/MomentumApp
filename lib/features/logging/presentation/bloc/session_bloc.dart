import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/notifications/notification_service.dart';
import 'package:momentum/features/logging/domain/entities/exercise_entry.dart';
import 'package:momentum/features/logging/domain/entities/set_row.dart';
import 'package:momentum/features/logging/domain/repositories/logging_repository.dart';
import 'package:momentum/features/logging/presentation/bloc/session_event.dart';
import 'package:momentum/features/logging/presentation/bloc/session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required LoggingRepository repo,
    NotificationService? notifications,
  }) : _repo = repo,
       _notifications = notifications,
       super(const SessionState.idle()) {
    on<SessionStarted>(_onStarted);
    on<ExercisePreFilled>(_onExercisePreFilled);
    on<SetRowValue>(_onSetRowValue);
    on<StepRowValue>(_onStepRowValue);
    on<RowToggled>(_onRowToggled);
    on<SetAdded>(_onSetAdded);
    on<SetRemoved>(_onSetRemoved);
    on<ExerciseReordered>(_onExerciseReordered);
    on<ExerciseToggled>(_onExerciseToggled);
    on<AdhocExerciseAdded>(_onAdhocExerciseAdded);
    on<StopwatchToggled>(_onStopwatchToggled);
    on<RestTimerStarted>(_onRestTimerStarted);
    on<RestTimerAdjusted>(_onRestTimerAdjusted);
    on<RestTimerTicked>(_onRestTimerTicked);
    on<RestTimerSkipped>(_onRestTimerSkipped);
    on<SetRowExpanded>(_onSetRowExpanded);
    on<ExerciseEquipmentChanged>(_onExerciseEquipmentChanged);
    on<ExerciseNoteChanged>(_onExerciseNoteChanged);
    on<ExerciseTargetChanged>(_onExerciseTargetChanged);
    on<CelebrationDismissed>(_onCelebrationDismissed);
    on<FinishRequested>(_onFinishRequested);
  }

  final LoggingRepository _repo;
  final NotificationService? _notifications;
  Timer? _restTimer;

  // ── Helpers ───────────────────────────────────────────────────────

  static String _uid() => DateTime.now().microsecondsSinceEpoch.toString();

  static List<ExerciseEntry> _mapSet(
    List<ExerciseEntry> exercises,
    String exerciseId,
    String setId,
    SetRow Function(SetRow) updater,
  ) {
    return exercises.map((ex) {
      if (ex.localId != exerciseId) return ex;
      return ex.copyWith(
        sets: ex.sets.map((s) {
          if (s.localId != setId) return s;
          return updater(s);
        }).toList(),
      );
    }).toList();
  }

  static SessionActive _maybeStartStopwatch(SessionActive s) {
    if (s.stopwatchRunning || s.stopwatchStartedAt != null) return s;
    return s.copyWith(
      stopwatchRunning: true,
      stopwatchStartedAt: DateTime.now(),
    );
  }

  static Map<String, double> _defaultMetrics(Modality modality) =>
      switch (modality) {
        Modality.strength => {'weight': 0, 'reps': 0},
        Modality.bodyweight => {'reps': 0},
        Modality.cardio => {'distanceKm': 0, 'timeMin': 0},
        Modality.timed => {'timeMin': 0},
      };

  // ── Event handlers ────────────────────────────────────────────────

  Future<void> _onStarted(
    SessionStarted event,
    Emitter<SessionState> emit,
  ) async {
    final result = await _repo
        .createSession(
          planId: event.planId,
          dayIndex: event.dayIndex,
          focus: event.focus,
        )
        .run();
    result.fold(
      (f) => emit(SessionState.error(f.message)),
      (sessionId) => emit(
        SessionState.active(
          sessionId: sessionId,
          exercises: event.exercises,
          focus: event.focus,
          planId: event.planId,
          dayIndex: event.dayIndex,
          planTotalDays: event.planTotalDays,
        ),
      ),
    );
  }

  /// Fills empty (never-touched) set rows with last session's values for
  /// this exercise — Smart Defaults, so the user doesn't retype a weight
  /// they already told the app. Deliberately does not start the stopwatch,
  /// unlike a real value entry.
  void _onExercisePreFilled(
    ExercisePreFilled event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    final exercises = s.exercises.map((ex) {
      if (ex.localId != event.exerciseLocalId) return ex;
      final sets = <SetRow>[];
      for (var i = 0; i < ex.sets.length; i++) {
        final row = ex.sets[i];
        final untouched =
            (row.metrics['weight'] ?? 0) == 0 &&
            (row.metrics['reps'] ?? 0) == 0;
        sets.add(
          untouched && i < event.setMetrics.length
              ? row.copyWith(metrics: event.setMetrics[i])
              : row,
        );
      }
      return ex.copyWith(sets: sets);
    }).toList();
    emit(s.copyWith(exercises: exercises));
  }

  void _onSetRowValue(
    SetRowValue event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    final updated = _mapSet(
      s.exercises,
      event.exerciseLocalId,
      event.setLocalId,
      (r) => r.copyWith(
        metrics: {...r.metrics, event.metricKey: event.value},
      ),
    );
    emit(_maybeStartStopwatch(s).copyWith(exercises: updated));
  }

  void _onStepRowValue(
    StepRowValue event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    final updated = _mapSet(
      s.exercises,
      event.exerciseLocalId,
      event.setLocalId,
      (r) {
        final current = r.metrics[event.metricKey] ?? 0;
        final next = (current + event.delta).clamp(0, 9999).toDouble();
        return r.copyWith(
          metrics: {...r.metrics, event.metricKey: next},
        );
      },
    );
    emit(_maybeStartStopwatch(s).copyWith(exercises: updated));
  }

  Future<void> _onRowToggled(
    RowToggled event,
    Emitter<SessionState> emit,
  ) async {
    final s = state;
    if (s is! SessionActive) return;

    ExerciseEntry? exercise;
    for (final ex in s.exercises) {
      if (ex.localId == event.exerciseLocalId) {
        exercise = ex;
        break;
      }
    }
    if (exercise == null) return;

    SetRow? set;
    for (final r in exercise.sets) {
      if (r.localId == event.setLocalId) {
        set = r;
        break;
      }
    }
    if (set == null) return;

    final markingDone = !set.isDone;

    final updatedExercises = _mapSet(
      s.exercises,
      event.exerciseLocalId,
      event.setLocalId,
      (r) => r.copyWith(isDone: markingDone),
    );

    final active = _maybeStartStopwatch(s).copyWith(
      exercises: updatedExercises,
    );
    emit(active);

    if (markingDone && exercise.modality == Modality.strength) {
      final weight = set.metrics['weight'] ?? 0;
      final reps = set.metrics['reps'] ?? 0;
      if (weight > 0 && reps > 0) {
        final newORM = weight * (1 + reps / 30);
        final result = await _repo.getBestOneRepMax(exercise.name).run();

        final current = state;
        if (current is! SessionActive) return;

        result.fold(
          (_) {},
          (bestORM) {
            if (bestORM == null || newORM > bestORM) {
              emit(
                current.copyWith(
                  exercises: current.exercises.map((ex) {
                    if (ex.localId != event.exerciseLocalId) {
                      return ex;
                    }
                    return ex.copyWith(isPrHighlighted: true);
                  }).toList(),
                  celebrationExercise: exercise!.name,
                ),
              );
            }
          },
        );
      }
      add(const SessionEvent.restTimerStarted(90));
    }
  }

  void _onSetAdded(SetAdded event, Emitter<SessionState> emit) {
    final s = state;
    if (s is! SessionActive) return;

    ExerciseEntry? exercise;
    for (final ex in s.exercises) {
      if (ex.localId == event.exerciseLocalId) {
        exercise = ex;
        break;
      }
    }
    if (exercise == null) return;

    final prevMetrics = exercise.sets.isNotEmpty
        ? exercise.sets.last.metrics
        : _defaultMetrics(exercise.modality);

    final newSet = SetRow(
      localId: _uid(),
      metrics: Map.of(prevMetrics),
    );

    final updated = s.exercises.map((ex) {
      if (ex.localId != event.exerciseLocalId) return ex;
      return ex.copyWith(sets: [...ex.sets, newSet]);
    }).toList();

    emit(s.copyWith(exercises: updated));
  }

  void _onSetRemoved(SetRemoved event, Emitter<SessionState> emit) {
    final s = state;
    if (s is! SessionActive) return;
    final updated = s.exercises.map((ex) {
      if (ex.localId != event.exerciseLocalId) return ex;
      return ex.copyWith(
        sets: ex.sets.where((r) => r.localId != event.setLocalId).toList(),
      );
    }).toList();
    emit(s.copyWith(exercises: updated));
  }

  void _onExerciseReordered(
    ExerciseReordered event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    final idx = event.newIndex > event.oldIndex
        ? event.newIndex - 1
        : event.newIndex;
    final reordered = [...s.exercises];
    final moved = reordered.removeAt(event.oldIndex);
    reordered.insert(idx, moved);
    emit(s.copyWith(exercises: reordered));
  }

  void _onExerciseToggled(
    ExerciseToggled event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    final updated = s.exercises.map((ex) {
      if (ex.localId != event.exerciseLocalId) return ex;
      return ex.copyWith(isCollapsed: !ex.isCollapsed);
    }).toList();
    emit(s.copyWith(exercises: updated));
  }

  void _onAdhocExerciseAdded(
    AdhocExerciseAdded event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    emit(s.copyWith(exercises: [...s.exercises, event.exercise]));
  }

  void _onStopwatchToggled(
    StopwatchToggled event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    if (s.stopwatchRunning) {
      emit(
        s.copyWith(
          stopwatchRunning: false,
          stopwatchPausedAt: DateTime.now(),
        ),
      );
    } else {
      final now = DateTime.now();
      final extraMs = s.stopwatchPausedAt != null
          ? now.difference(s.stopwatchPausedAt!).inMilliseconds
          : 0;
      emit(
        s.copyWith(
          stopwatchRunning: true,
          stopwatchStartedAt: s.stopwatchStartedAt ?? now,
          stopwatchPausedAt: null,
          totalPausedMs: s.totalPausedMs + extraMs,
        ),
      );
    }
  }

  void _onRestTimerStarted(
    RestTimerStarted event,
    Emitter<SessionState> emit,
  ) {
    _restTimer?.cancel();
    final s = state;
    if (s is! SessionActive) return;
    emit(
      s.copyWith(
        restSecondsLeft: event.seconds,
        restSecondsTotal: event.seconds,
      ),
    );
    _restTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(const SessionEvent.restTimerTicked()),
    );
    unawaited(_notifications?.scheduleRestComplete(event.seconds));
  }

  void _onRestTimerAdjusted(
    RestTimerAdjusted event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    if (s.restSecondsLeft == null) return;
    final next = (s.restSecondsLeft! + event.delta).clamp(5, 600);
    emit(s.copyWith(restSecondsLeft: next));
  }

  void _onRestTimerTicked(
    RestTimerTicked event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive || s.restSecondsLeft == null) return;
    final next = s.restSecondsLeft! - 1;
    if (next <= 0) {
      _restTimer?.cancel();
      _restTimer = null;
      // Notification already fired via zonedSchedule; cancel any pending one
      // to avoid a stale notification if the timer was restarted mid-count.
      unawaited(_notifications?.cancelRestNotification());
      emit(s.copyWith(restSecondsLeft: null, restSecondsTotal: null));
    } else {
      emit(s.copyWith(restSecondsLeft: next));
    }
  }

  void _onRestTimerSkipped(
    RestTimerSkipped event,
    Emitter<SessionState> emit,
  ) {
    _restTimer?.cancel();
    _restTimer = null;
    unawaited(_notifications?.cancelRestNotification());
    final s = state;
    if (s is! SessionActive) return;
    emit(s.copyWith(restSecondsLeft: null, restSecondsTotal: null));
  }

  void _onSetRowExpanded(
    SetRowExpanded event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    final updated = _mapSet(
      s.exercises,
      event.exerciseLocalId,
      event.setLocalId,
      (r) => r.copyWith(isExpanded: event.expanded),
    );
    emit(s.copyWith(exercises: updated));
  }

  void _onCelebrationDismissed(
    CelebrationDismissed event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    emit(s.copyWith(celebrationExercise: null));
  }

  Future<void> _onFinishRequested(
    FinishRequested event,
    Emitter<SessionState> emit,
  ) async {
    final s = state;
    if (s is! SessionActive) return;

    _restTimer?.cancel();
    _restTimer = null;

    emit(const SessionState.saving());

    final now = DateTime.now();
    final durationSeconds = _computeElapsedSeconds(s, now);

    final result = await _repo
        .finishSession(
          sessionId: s.sessionId,
          endedAt: now,
          durationSeconds: durationSeconds,
          exercises: s.exercises,
          planId: s.planId,
          dayIndex: s.dayIndex,
        )
        .run();

    result.fold(
      (f) => emit(SessionState.error(f.message)),
      (_) => emit(const SessionState.finished()),
    );
  }

  static int _computeElapsedSeconds(SessionActive s, DateTime now) {
    final started = s.stopwatchStartedAt;
    if (started == null) return 0;
    final totalMs = now.difference(started).inMilliseconds;
    final pausedMs =
        s.totalPausedMs +
        (s.stopwatchPausedAt != null
            ? now.difference(s.stopwatchPausedAt!).inMilliseconds
            : 0);
    return ((totalMs - pausedMs) / 1000).round().clamp(0, 99999);
  }

  void _onExerciseEquipmentChanged(
    ExerciseEquipmentChanged event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    emit(
      s.copyWith(
        exercises: s.exercises.map((ex) {
          if (ex.localId != event.exerciseLocalId) return ex;
          return ex.copyWith(equipment: event.equipment);
        }).toList(),
      ),
    );
  }

  void _onExerciseNoteChanged(
    ExerciseNoteChanged event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    emit(
      s.copyWith(
        exercises: s.exercises.map((ex) {
          if (ex.localId != event.exerciseLocalId) return ex;
          return ex.copyWith(exerciseNote: event.note);
        }).toList(),
      ),
    );
  }

  void _onExerciseTargetChanged(
    ExerciseTargetChanged event,
    Emitter<SessionState> emit,
  ) {
    final s = state;
    if (s is! SessionActive) return;
    emit(
      s.copyWith(
        exercises: s.exercises.map((ex) {
          if (ex.localId != event.exerciseLocalId) return ex;
          return ex.copyWith(targetWeight: event.targetWeight);
        }).toList(),
      ),
    );
  }

  @override
  Future<void> close() {
    _restTimer?.cancel();
    return super.close();
  }
}
