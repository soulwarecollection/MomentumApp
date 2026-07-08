import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/goals/domain/entities/goal.dart';
import 'package:momentum/features/goals/domain/repositories/goal_repository.dart';

@LazySingleton(as: GoalRepository)
class GoalRepositoryImpl implements GoalRepository {
  const GoalRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<Goal?> watchActive() {
    return _db.goalsDao.watchActive().map((row) {
      if (row == null) return null;
      return Goal(
        id: row.id,
        type: row.type,
        targetValue: row.targetValue,
        deadline: row.deadline,
        createdAt: row.createdAt,
        startValue: row.startValue,
        exerciseName: row.exerciseName,
      );
    });
  }

  @override
  Future<void> setGoal(Goal goal) async {
    await _db.goalsDao.deactivateAll();
    await _db.goalsDao.insertGoal(
      GoalsCompanion.insert(
        type: goal.type,
        targetValue: goal.targetValue,
        deadline: goal.deadline,
        createdAt: goal.createdAt,
        startValue: Value(goal.startValue),
        exerciseName: Value(goal.exerciseName),
      ),
    );
  }

  @override
  Future<void> clearGoal() => _db.goalsDao.deactivateAll();
}
