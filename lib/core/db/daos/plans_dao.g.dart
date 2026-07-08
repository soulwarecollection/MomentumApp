// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans_dao.dart';

// ignore_for_file: type=lint
mixin _$PlansDaoMixin on DatabaseAccessor<AppDatabase> {
  $PlansTable get plans => attachedDatabase.plans;
  $PlanDaysTable get planDays => attachedDatabase.planDays;
  $PlanExercisesTable get planExercises => attachedDatabase.planExercises;
  PlansDaoManager get managers => PlansDaoManager(this);
}

class PlansDaoManager {
  final _$PlansDaoMixin _db;
  PlansDaoManager(this._db);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db.attachedDatabase, _db.plans);
  $$PlanDaysTableTableManager get planDays =>
      $$PlanDaysTableTableManager(_db.attachedDatabase, _db.planDays);
  $$PlanExercisesTableTableManager get planExercises =>
      $$PlanExercisesTableTableManager(_db.attachedDatabase, _db.planExercises);
}
