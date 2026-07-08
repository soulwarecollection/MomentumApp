import 'package:drift/drift.dart';

@DataClassName('WeightEntryRow')
class WeightEntries extends Table {
  @override
  String get tableName => 'weight_entries';

  IntColumn get id => integer().autoIncrement()();
  RealColumn get weightKg => real()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get recordedAt => dateTime()();
}
