import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/enums/goal_type.dart';
import 'package:momentum/features/goals/data/repositories/goal_repository_impl.dart';
import 'package:momentum/features/goals/domain/entities/goal.dart';

// ── Fixtures ──────────────────────────────────────────────────────────────

final _now = DateTime(2026, 6, 30);
final _deadline = DateTime(2026, 9, 30);

Goal _goal({
  GoalType type = GoalType.fatLoss,
  double targetValue = 75,
  String? exerciseName,
}) => Goal(
  id: 0,
  type: type,
  targetValue: targetValue,
  deadline: _deadline,
  createdAt: _now,
  startValue: 85,
  exerciseName: exerciseName,
);

// ── Tests ─────────────────────────────────────────────────────────────────

void main() {
  late AppDatabase db;
  late GoalRepositoryImpl repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = GoalRepositoryImpl(db);
  });

  tearDown(() => db.close());

  group('GoalRepositoryImpl', () {
    group('watchActive', () {
      test('emits null when no goals exist', () async {
        final result = await repo.watchActive().first;
        expect(result, isNull);
      });

      test('emits Goal after setGoal', () async {
        await repo.setGoal(_goal());
        final result = await repo.watchActive().first;
        expect(result, isNotNull);
        expect(result!.type, GoalType.fatLoss);
        expect(result.targetValue, 75);
      });

      test('maps exerciseName correctly for strength PR goal', () async {
        await repo.setGoal(
          _goal(type: GoalType.strengthPr, exerciseName: 'Squat'),
        );
        final result = await repo.watchActive().first;
        expect(result!.exerciseName, 'Squat');
      });
    });

    group('setGoal', () {
      test('replaces previous active goal', () async {
        await repo.setGoal(_goal());
        await repo.setGoal(_goal(targetValue: 70));
        final result = await repo.watchActive().first;
        expect(result!.targetValue, 70);
      });

      test('only one goal is active at a time after multiple sets', () async {
        await repo.setGoal(_goal());
        await repo.setGoal(_goal(targetValue: 72));
        await repo.setGoal(_goal(targetValue: 68));
        final activeCount = await db.goalsDao.watchActive().first;
        expect(activeCount, isNotNull);
        final allActive = await (db.select(
          db.goals,
        )..where((g) => g.isActive.equals(true))).get();
        expect(allActive.length, 1);
      });
    });

    group('clearGoal', () {
      test('watchActive emits null after clearGoal', () async {
        await repo.setGoal(_goal());
        await repo.clearGoal();
        final result = await repo.watchActive().first;
        expect(result, isNull);
      });

      test('clearGoal is idempotent when no goal exists', () async {
        await expectLater(repo.clearGoal(), completes);
      });
    });
  });
}
