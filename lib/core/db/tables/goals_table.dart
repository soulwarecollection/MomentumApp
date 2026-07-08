import 'package:drift/drift.dart';
import 'package:momentum/core/enums/goal_type.dart';

@DataClassName('GoalRow')
class Goals extends Table {
  @override
  String get tableName => 'goals';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => textEnum<GoalType>()();
  RealColumn get targetValue => real()();
  DateTimeColumn get deadline => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  RealColumn get startValue => real().nullable()();
  TextColumn get exerciseName => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
