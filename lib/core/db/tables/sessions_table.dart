import 'package:drift/drift.dart';
import 'package:momentum/core/db/tables/plans_table.dart';

@DataClassName('SessionRow')
class Sessions extends Table {
  @override
  String get tableName => 'sessions';

  IntColumn get id => integer().autoIncrement()();

  /// Null for freestyle (ad-hoc) sessions.
  IntColumn get planId => integer().nullable().references(Plans, #id)();

  /// Day slot within the plan; null for freestyle.
  IntColumn get dayIndex => integer().nullable()();

  TextColumn get focus => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get durationSeconds => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get remoteId => text().nullable().unique()();
}
