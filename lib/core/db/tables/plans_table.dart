import 'package:drift/drift.dart';

@DataClassName('PlanRow')
class Plans extends Table {
  @override
  String get tableName => 'plans';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get currentDayIndex => integer().withDefault(const Constant(0))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  // Null until the row has been pushed to the sync server at least once.
  TextColumn get remoteId => text().nullable().unique()();
}
