import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/routines/data/repositories/routines_repository_impl.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';

void main() {
  late AppDatabase db;
  late RoutinesRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = RoutinesRepositoryImpl(db);
  });

  tearDown(() => db.close());

  group('RoutinesRepositoryImpl', () {
    test('createPlan surfaces plan in watchPlans', () async {
      final result = await repo.createPlan('PPL').run();
      expect(result.isRight(), isTrue);
      final plans = await repo.watchPlans().first;
      expect(plans.getOrElse((_) => []), hasLength(1));
      expect(
        plans.getOrElse((_) => []).first.name,
        'PPL',
      );
    });

    test('deletePlan soft-deletes — plan disappears from watchPlans', () async {
      final id = (await repo.createPlan('PPL').run()).getOrElse((_) => 0);
      await repo.deletePlan(id).run();
      final plans = await repo.watchPlans().first;
      expect(plans.getOrElse((_) => []), isEmpty);
    });

    test('setActivePlan deactivates all other plans', () async {
      final id1 = (await repo.createPlan('A').run()).getOrElse((_) => 0);
      final id2 = (await repo.createPlan('B').run()).getOrElse((_) => 0);
      await repo.setActivePlan(id2).run();
      final plans = await repo.watchPlans().first;
      final list = plans.getOrElse((_) => []);
      final a = list.firstWhere((p) => p.id == id1);
      final b = list.firstWhere((p) => p.id == id2);
      expect(a.isActive, isFalse);
      expect(b.isActive, isTrue);
    });

    test('addDay and deleteDay — cascade removes exercises', () async {
      final planId = (await repo.createPlan('PPL').run()).getOrElse((_) => 0);
      final dayId =
          (await repo.addDay(planId, isRest: false, focus: 'Push').run())
              .getOrElse((_) => 0);
      await repo.addExercise(dayId, name: 'Bench Press', targetSets: 4).run();

      await repo.deleteDay(dayId).run();

      final days = await repo.watchPlanDays(planId).first;
      expect(days.getOrElse((_) => []), isEmpty);

      final exs = await repo.watchAllExercisesForPlan(planId).first;
      expect(exs.getOrElse((_) => []), isEmpty);
    });

    test('duplicatePlan copies days and exercises', () async {
      final planId = (await repo.createPlan('PPL').run()).getOrElse((_) => 0);
      final dayId =
          (await repo.addDay(planId, isRest: false, focus: 'Push').run())
              .getOrElse((_) => 0);
      await repo.addExercise(dayId, name: 'Squat').run();

      final newId = (await repo.duplicatePlan(planId).run()).getOrElse(
        (_) => 0,
      );
      expect(newId, isNot(planId));

      final newDays = await repo.watchPlanDays(newId).first;
      expect(newDays.getOrElse((_) => []), hasLength(1));

      final newExs = await repo.watchAllExercisesForPlan(newId).first;
      expect(newExs.getOrElse((_) => []), hasLength(1));
      expect(
        newExs.getOrElse((_) => []).first.name,
        'Squat',
      );
    });
  });
}
