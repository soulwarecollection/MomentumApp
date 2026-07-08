import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/db/app_database.dart';

void main() {
  late AppDatabase db;
  late PlansDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = db.plansDao;
  });

  tearDown(() async => db.close());

  group('PlansDao', () {
    PlansCompanion makePlan({String name = 'PPL'}) {
      final now = DateTime.now();
      return PlansCompanion.insert(
        name: name,
        createdAt: now,
        updatedAt: now,
      );
    }

    PlanDaysCompanion makeDay(int planId, int order) =>
        PlanDaysCompanion.insert(
          planId: planId,
          orderIndex: order,
        );

    test('inserting a plan surfaces it in watchActivePlans', () async {
      await dao.insertPlan(makePlan());
      final plans = await dao.watchActivePlans().first;
      expect(plans, hasLength(1));
      expect(plans.first.name, 'PPL');
    });

    test('softDeletePlan hides it from watchActivePlans', () async {
      final id = await dao.insertPlan(makePlan());
      await dao.softDeletePlan(id);
      final plans = await dao.watchActivePlans().first;
      expect(plans, isEmpty);
    });

    test('watchPlanDays returns days in orderIndex order', () async {
      final planId = await dao.insertPlan(makePlan());
      await dao.insertPlanDay(makeDay(planId, 2));
      await dao.insertPlanDay(makeDay(planId, 0));
      await dao.insertPlanDay(makeDay(planId, 1));

      final days = await dao.watchPlanDays(planId).first;
      expect(days.map((d) => d.orderIndex), [0, 1, 2]);
    });

    test('advanceCursor updates currentDayIndex', () async {
      final id = await dao.insertPlan(makePlan());
      await dao.advanceCursor(id, 2);
      final plans = await dao.watchActivePlans().first;
      expect(plans.first.currentDayIndex, 2);
    });

    test('deletePlanDays removes all days for a plan', () async {
      final planId = await dao.insertPlan(makePlan());
      await dao.insertPlanDay(makeDay(planId, 0));
      await dao.insertPlanDay(makeDay(planId, 1));
      await dao.deletePlanDays(planId);
      final days = await dao.watchPlanDays(planId).first;
      expect(days, isEmpty);
    });
  });
}
