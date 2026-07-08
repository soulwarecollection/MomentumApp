import 'package:drift/drift.dart';
import 'package:momentum/core/db/tables/sessions_table.dart';
import 'package:momentum/core/enums/equipment_type.dart';
import 'package:momentum/core/enums/modality.dart';

@DataClassName('SessionExerciseRow')
class SessionExercises extends Table {
  @override
  String get tableName => 'session_exercises';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId =>
      integer().references(Sessions, #id, onDelete: KeyAction.cascade)();
  IntColumn get orderIndex => integer()();
  TextColumn get name => text()();
  TextColumn get equipment => textEnum<EquipmentType>().nullable()();
  TextColumn get exerciseNote => text().nullable()();
  TextColumn get modality => textEnum<Modality>()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  TextColumn get remoteId => text().nullable().unique()();
}
