import 'package:momentum/features/goals/domain/entities/goal.dart';

enum GoalSuggestion { checkCalories, strengthBehind }

class GoalProgress {
  const GoalProgress({
    required this.goal,
    required this.currentValue,
    required this.progressFraction,
    required this.daysRemaining,
    required this.isOnPace,
    required this.gapValue,
    this.suggestion,
  });

  final Goal goal;

  /// Current body weight (kg) for weight goals; current best 1RM for strength.
  final double currentValue;

  /// 0.0–1.0, clamped — drives the progress bar.
  final double progressFraction;

  final int daysRemaining;
  final bool isOnPace;

  /// |target − current|, always ≥ 0.
  final double gapValue;

  final GoalSuggestion? suggestion;

  bool get isComplete => progressFraction >= 1.0;
}
