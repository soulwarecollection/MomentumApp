import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/routines/presentation/cubits/plan_editor_cubit.dart';
import 'package:momentum/features/routines/presentation/cubits/plan_editor_state.dart';

class MockRoutinesRepository extends Mock implements RoutinesRepository {}

void main() {
  late MockRoutinesRepository repo;

  const planId = 1;

  final fakePlan = Plan(
    id: planId,
    name: 'PPL',
    isActive: false,
    currentDayIndex: 0,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  const fakeDay = PlanDay(
    id: 10,
    planId: planId,
    orderIndex: 0,
    isRest: false,
    focus: 'Push',
  );

  const fakeExercise = PlanExercise(
    id: 100,
    planDayId: 10,
    orderIndex: 0,
    name: 'Bench Press',
  );

  setUp(() {
    repo = MockRoutinesRepository();
    registerFallbackValue(fakeDay);
    registerFallbackValue(fakeExercise);
  });

  PlanEditorCubit buildCubit() => PlanEditorCubit(repo: repo, planId: planId);

  group('PlanEditorCubit', () {
    blocTest<PlanEditorCubit, PlanEditorState>(
      'emits loaded after successful init',
      setUp: () {
        when(
          () => repo.getPlan(planId),
        ).thenAnswer((_) => TaskEither.of(fakePlan));
        when(() => repo.watchPlanDays(planId)).thenAnswer(
          (_) => Stream.value(right([fakeDay])),
        );
        when(() => repo.watchAllExercisesForPlan(planId)).thenAnswer(
          (_) => Stream.value(right([fakeExercise])),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.init(),
      expect: () => [isA<PlanEditorLoaded>()],
      verify: (cubit) {
        final s = cubit.state as PlanEditorLoaded;
        expect(s.plan, fakePlan);
        expect(s.days, hasLength(1));
        expect(s.days.first.day, fakeDay);
        expect(s.days.first.exercises, [fakeExercise]);
      },
    );

    blocTest<PlanEditorCubit, PlanEditorState>(
      'emits error when getPlan fails',
      setUp: () {
        when(() => repo.getPlan(planId)).thenAnswer(
          (_) => TaskEither.left(
            const CacheFailure(message: 'not found'),
          ),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.init(),
      expect: () => [isA<PlanEditorError>()],
    );

    blocTest<PlanEditorCubit, PlanEditorState>(
      'addDay delegates to repo',
      setUp: () {
        when(
          () => repo.getPlan(planId),
        ).thenAnswer((_) => TaskEither.of(fakePlan));
        when(
          () => repo.watchPlanDays(planId),
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => repo.watchAllExercisesForPlan(planId),
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => repo.addDay(
            planId,
            isRest: any(named: 'isRest'),
            focus: any(named: 'focus'),
          ),
        ).thenAnswer((_) => TaskEither.of(10));
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.init();
        final result = await cubit.addDay(isRest: false);
        expect(result.isRight(), isTrue);
      },
      expect: () => <PlanEditorState>[],
    );
  });
}
