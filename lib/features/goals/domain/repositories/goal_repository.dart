import 'package:momentum/features/goals/domain/entities/goal.dart';

abstract class GoalRepository {
  Stream<Goal?> watchActive();
  Future<void> setGoal(Goal goal);
  Future<void> clearGoal();
}
