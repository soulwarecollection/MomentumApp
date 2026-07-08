import 'package:drift/drift.dart';
import 'package:momentum/core/db/tables/plans_table.dart';

@DataClassName('PlanDayRow')
class PlanDays extends Table {
  @override
  String get tableName => 'plan_days';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get planId =>
      integer().references(Plans, #id, onDelete: KeyAction.cascade)();
  IntColumn get orderIndex => integer()();
  TextColumn get focus => text().nullable()();
  BoolColumn get isRest => boolean().withDefault(const Constant(false))();
  // Null on rows created before the sync feature was added; treated as epoch.
  DateTimeColumn get updatedAt => dateTime().nullable()();
  TextColumn get remoteId => text().nullable().unique()();
}
