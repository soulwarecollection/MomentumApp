import 'package:drift/drift.dart';
import 'package:momentum/core/enums/modality.dart';

@DataClassName('ExerciseRow')
class Exercises extends Table {
  @override
  String get tableName => 'exercises';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get modality => textEnum<Modality>()();
  TextColumn get muscleGroup => text().nullable()();
  TextColumn get equipment => text().nullable()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
