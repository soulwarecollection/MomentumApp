import 'package:drift/drift.dart';
import 'package:momentum/core/db/tables/metrics_converter.dart';
import 'package:momentum/core/db/tables/session_exercises_table.dart';
import 'package:momentum/core/enums/modality.dart';

@DataClassName('LoggedSetRow')
class LoggedSets extends Table {
  @override
  String get tableName => 'logged_sets';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionExerciseId => integer().references(
    SessionExercises,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get orderIndex => integer()();

  /// Denormalized from the parent exercise for fast per-set queries.
  TextColumn get modality => textEnum<Modality>()();

  /// Flexible metric map — see [Modality] for keys per modality.
  TextColumn get metrics => text().map(const MetricsConverter())();

  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  TextColumn get remoteId => text().nullable().unique()();
}
