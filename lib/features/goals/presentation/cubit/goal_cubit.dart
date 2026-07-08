import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/enums/goal_type.dart';
import 'package:momentum/core/notifications/notification_service.dart';
import 'package:momentum/features/goals/domain/entities/goal.dart';
import 'package:momentum/features/goals/domain/entities/goal_progress.dart';
import 'package:momentum/features/goals/domain/repositories/goal_repository.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_state.dart';
import 'package:momentum/features/logging/domain/repositories/logging_repository.dart';
import 'package:momentum/features/weight/domain/repositories/weight_repository.dart';

@singleton
class GoalCubit extends Cubit<GoalState> {
  GoalCubit(this._goalRepo, this._weightRepo, this._loggingRepo)
    : super(const GoalState.loading());

  final GoalRepository _goalRepo;
  final WeightRepository _weightRepo;
  final LoggingRepository _loggingRepo;
  NotificationService? _notifications;

  StreamSubscription<Goal?>? _goalSub;
  StreamSubscription<List<WeightEntryRow>>? _weightSub;
  Goal? _currentGoal;
  List<WeightEntryRow> _weightEntries = [];

  void init([NotificationService? notifications]) {
    _notifications = notifications;
    _goalSub = _goalRepo.watchActive().listen(
      _onGoalChanged,
      onError: (Object e) => emit(GoalState.error(e.toString())),
    );
  }

  Future<void> _onGoalChanged(Goal? goal) async {
    _currentGoal = goal;

    if (goal == null) {
      await _weightSub?.cancel();
      _weightSub = null;
      _weightEntries = [];
      emit(const GoalState.noGoal());
      return;
    }

    if (goal.type != GoalType.strengthPr) {
      if (_weightSub == null) {
        _weightSub = _weightRepo.watchAll().listen(
          (entries) {
            _weightEntries = entries;
            _emitWeightProgress();
          },
          onError: (Object e) => emit(GoalState.error(e.toString())),
        );
      } else {
        _emitWeightProgress();
      }
    } else {
      await _weightSub?.cancel();
      _weightSub = null;
      await _emitStrengthProgress(goal);
    }
  }

  void _emitWeightProgress() {
    final goal = _currentGoal;
    if (goal == null) return;
    final progress = _computeWeightProgress(goal, _weightEntries);
    emit(GoalState.active(progress));
    unawaited(_scheduleNudge(progress));
  }

  Future<void> _emitStrengthProgress(Goal goal) async {
    final result = await _loggingRepo
        .getBestOneRepMax(goal.exerciseName ?? '')
        .run();
    final currentOrm = result.getOrElse((_) => null) ?? goal.startValue ?? 0.0;
    final progress = _computeStrengthProgress(goal, currentOrm);
    emit(GoalState.active(progress));
    unawaited(_scheduleNudge(progress));
  }

  // ── Computation ──────────────────────────────────────────────────────────

  static GoalProgress _computeWeightProgress(
    Goal goal,
    List<WeightEntryRow> entries,
  ) {
    final startVal = goal.startValue ?? 0.0;
    final targetVal = goal.targetValue;
    final currentVal = entries.isNotEmpty ? entries.first.weightKg : startVal;

    final totalDelta = (targetVal - startVal).abs();
    final achievedDelta = goal.type == GoalType.fatLoss
        ? startVal - currentVal
        : currentVal - startVal;

    final fraction = totalDelta == 0
        ? 1.0
        : (achievedDelta / totalDelta).clamp(0.0, 1.0);

    final now = DateTime.now();
    final daysTotal = goal.deadline
        .difference(goal.createdAt)
        .inDays
        .clamp(1, 999);
    final daysElapsed = now.difference(goal.createdAt).inDays;
    final daysRemaining = goal.deadline.difference(now).inDays;
    final expectedFraction = (daysElapsed / daysTotal).clamp(0.0, 1.0);
    final isOnPace = fraction >= expectedFraction - 0.05;

    final suggestion = _detectWeightSuggestion(
      goal: goal,
      entries: entries,
      fraction: fraction,
      isOnPace: isOnPace,
    );

    return GoalProgress(
      goal: goal,
      currentValue: currentVal,
      progressFraction: fraction,
      daysRemaining: math.max(0, daysRemaining),
      isOnPace: isOnPace,
      gapValue: (targetVal - currentVal).abs(),
      suggestion: suggestion,
    );
  }

  static GoalSuggestion? _detectWeightSuggestion({
    required Goal goal,
    required List<WeightEntryRow> entries,
    required double fraction,
    required bool isOnPace,
  }) {
    if (fraction >= 1.0) return null;
    if (entries.length >= 5) {
      final weights = entries.take(5).map((e) => e.weightKg);
      final spread = weights.reduce(math.max) - weights.reduce(math.min);
      if (spread <= 0.5 && !isOnPace) return GoalSuggestion.checkCalories;
    }
    return null;
  }

  static GoalProgress _computeStrengthProgress(
    Goal goal,
    double currentOrm,
  ) {
    final startVal = goal.startValue ?? 0.0;
    final targetVal = goal.targetValue;
    final totalDelta = math.max(1, targetVal - startVal);
    final achievedDelta = (currentOrm - startVal).clamp(0.0, totalDelta);
    final fraction = (achievedDelta / totalDelta).clamp(0.0, 1.0);

    final now = DateTime.now();
    final daysTotal = goal.deadline
        .difference(goal.createdAt)
        .inDays
        .clamp(1, 999);
    final daysElapsed = now.difference(goal.createdAt).inDays;
    final daysRemaining = goal.deadline.difference(now).inDays;
    final expectedFraction = (daysElapsed / daysTotal).clamp(0.0, 1.0);
    final isOnPace = fraction >= expectedFraction - 0.05;

    return GoalProgress(
      goal: goal,
      currentValue: currentOrm,
      progressFraction: fraction,
      daysRemaining: math.max(0, daysRemaining),
      isOnPace: isOnPace,
      gapValue: math.max(0, targetVal - currentOrm),
      suggestion: !isOnPace && fraction < 1.0
          ? GoalSuggestion.strengthBehind
          : null,
    );
  }

  // ── Public API ───────────────────────────────────────────────────────────

  Future<void> setGoal(Goal goal) => _goalRepo.setGoal(goal);
  Future<void> clearGoal() => _goalRepo.clearGoal();

  /// Call after a session finishes to refresh strength-goal progress.
  Future<void> refreshStrengthProgress() async {
    final goal = _currentGoal;
    if (goal == null || goal.type != GoalType.strengthPr) return;
    await _emitStrengthProgress(goal);
  }

  // ── Notification nudge ───────────────────────────────────────────────────

  static const _nudgeCopy = [
    'Keep pushing — every rep counts.',
    'Consistency beats intensity every time.',
    'Small steps lead to big results.',
    'Stay the course — progress is coming.',
    "You're building a habit that lasts.",
    'One day at a time.',
    'Trust the process.',
  ];

  Future<void> _scheduleNudge(GoalProgress progress) async {
    if (_notifications == null || progress.isComplete) return;
    final day = DateTime.now().difference(DateTime(2024)).inDays;
    final copy = _nudgeCopy[day % _nudgeCopy.length];
    final gap = progress.gapValue.toStringAsFixed(1);
    final pace = progress.isOnPace ? "You're on pace." : 'Pick up the pace.';

    final bodyParts = <String>[];
    if (progress.gapValue > 0) {
      bodyParts.add('$gap kg to go');
      if (progress.goal.type == GoalType.strengthPr &&
          progress.goal.exerciseName != null) {
        bodyParts.add('on ${progress.goal.exerciseName}');
      }
    }
    bodyParts.add(pace);

    await _notifications!.scheduleGoalNudge(
      title: copy,
      body: bodyParts.join(' — '),
    );
  }

  @override
  Future<void> close() {
    unawaited(_goalSub?.cancel());
    unawaited(_weightSub?.cancel());
    return super.close();
  }
}
