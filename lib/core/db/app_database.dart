import 'package:drift/drift.dart';
import 'package:momentum/core/db/daos/exercises_dao.dart';
import 'package:momentum/core/db/daos/goals_dao.dart';
import 'package:momentum/core/db/daos/logged_sets_dao.dart';
import 'package:momentum/core/db/daos/plans_dao.dart';
import 'package:momentum/core/db/daos/sessions_dao.dart';
import 'package:momentum/core/db/daos/weight_entries_dao.dart';
import 'package:momentum/core/db/tables/exercises_table.dart';
import 'package:momentum/core/db/tables/goals_table.dart';
import 'package:momentum/core/db/tables/logged_sets_table.dart';
import 'package:momentum/core/db/tables/metrics_converter.dart';
import 'package:momentum/core/db/tables/plan_days_table.dart';
import 'package:momentum/core/db/tables/plan_exercises_table.dart';
import 'package:momentum/core/db/tables/plans_table.dart';
import 'package:momentum/core/db/tables/session_exercises_table.dart';
import 'package:momentum/core/db/tables/sessions_table.dart';
import 'package:momentum/core/db/tables/weight_entries_table.dart';
import 'package:momentum/core/enums/equipment_type.dart';
import 'package:momentum/core/enums/goal_type.dart';
import 'package:momentum/core/enums/modality.dart';

export 'package:momentum/core/db/daos/exercises_dao.dart';
export 'package:momentum/core/db/daos/goals_dao.dart';
export 'package:momentum/core/db/daos/logged_sets_dao.dart';
export 'package:momentum/core/db/daos/plans_dao.dart';
export 'package:momentum/core/db/daos/sessions_dao.dart';
export 'package:momentum/core/db/daos/weight_entries_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Plans,
    PlanDays,
    PlanExercises,
    Sessions,
    SessionExercises,
    LoggedSets,
    Exercises,
    WeightEntries,
    Goals,
  ],
  daos: [
    PlansDao,
    SessionsDao,
    LoggedSetsDao,
    ExercisesDao,
    WeightEntriesDao,
    GoalsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(exercises);
      }
      if (from < 3) {
        // Drift stores DateTime as INTEGER (µs since epoch).
        // SQLite allows ADD COLUMN for nullable columns with no default.
        // customStatement is called on the database, not the Migrator.
        await customStatement(
          'ALTER TABLE plans ADD COLUMN remote_id TEXT',
        );
        await customStatement(
          'ALTER TABLE sessions ADD COLUMN remote_id TEXT',
        );
        await customStatement(
          'ALTER TABLE plan_days ADD COLUMN updated_at INTEGER',
        );
        await customStatement(
          'ALTER TABLE plan_days ADD COLUMN remote_id TEXT',
        );
        await customStatement(
          'ALTER TABLE plan_exercises ADD COLUMN updated_at INTEGER',
        );
        await customStatement(
          'ALTER TABLE plan_exercises ADD COLUMN remote_id TEXT',
        );
        await customStatement(
          'ALTER TABLE session_exercises ADD COLUMN updated_at INTEGER',
        );
        await customStatement(
          'ALTER TABLE session_exercises ADD COLUMN remote_id TEXT',
        );
        await customStatement(
          'ALTER TABLE logged_sets ADD COLUMN updated_at INTEGER',
        );
        await customStatement(
          'ALTER TABLE logged_sets ADD COLUMN remote_id TEXT',
        );
      }
      if (from < 4) {
        await m.createTable(weightEntries);
      }
      if (from < 5) {
        await customStatement(
          'ALTER TABLE session_exercises ADD COLUMN exercise_note TEXT',
        );
      }
      if (from < 6) {
        await m.createTable(goals);
      }
      if (from < 7) {
        await customStatement(
          'ALTER TABLE plans'
          ' ADD COLUMN sort_order INTEGER NOT NULL DEFAULT 0',
        );
        // Seed sort_order from id so existing plans keep creation order.
        await customStatement(
          'UPDATE plans SET sort_order = id WHERE deleted_at IS NULL',
        );
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await exercisesDao.seedIfEmpty();
    },
  );
}
