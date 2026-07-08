import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';

extension PlanRowMapper on PlanRow {
  Plan toEntity() => Plan(
    id: id,
    name: name,
    isActive: isActive,
    currentDayIndex: currentDayIndex,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );
}

extension PlanDayRowMapper on PlanDayRow {
  PlanDay toEntity() => PlanDay(
    id: id,
    planId: planId,
    orderIndex: orderIndex,
    isRest: isRest,
    focus: focus,
  );
}

extension PlanExerciseRowMapper on PlanExerciseRow {
  PlanExercise toEntity() => PlanExercise(
    id: id,
    planDayId: planDayId,
    orderIndex: orderIndex,
    name: name,
    equipment: equipment,
    targetSets: targetSets,
    scheme: scheme,
    target: target,
  );
}
