import 'package:drift/drift.dart';
import 'package:momentum/core/db/tables/plan_days_table.dart';

@DataClassName('PlanExerciseRow')
class PlanExercises extends Table {
  @override
  String get tableName => 'plan_exercises';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get planDayId =>
      integer().references(PlanDays, #id, onDelete: KeyAction.cascade)();
  IntColumn get orderIndex => integer()();
  TextColumn get name => text()();
  TextColumn get equipment => text().nullable()();

  /// e.g. 3 (number of target sets per session).
  IntColumn get targetSets => integer().nullable()();

  /// Prescription shorthand, e.g. "3×8", "5-5-5+", "AMRAP".
  TextColumn get scheme => text().nullable()();

  /// Load target, e.g. "75 kg", "80 % 1RM", "bodyweight".
  TextColumn get target => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  TextColumn get remoteId => text().nullable().unique()();
}
