import 'package:drift/drift.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/db/tables/goals_table.dart';

part 'goals_dao.g.dart';

@DriftAccessor(tables: [Goals])
class GoalsDao extends DatabaseAccessor<AppDatabase> with _$GoalsDaoMixin {
  GoalsDao(super.attachedDatabase);

  Stream<GoalRow?> watchActive() {
    return (select(goals)
          ..where((t) => t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .watchSingleOrNull();
  }

  Future<void> deactivateAll() =>
      (update(goals)..where((_) => const Constant(true))).write(
        const GoalsCompanion(isActive: Value(false)),
      );

  Future<int> insertGoal(GoalsCompanion entry) => into(goals).insert(entry);

  Future<void> deleteGoal(int id) =>
      (delete(goals)..where((t) => t.id.equals(id))).go();
}
