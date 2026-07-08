import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/routines/presentation/cubits/plans_cubit.dart';
import 'package:momentum/features/routines/presentation/cubits/plans_state.dart';

class MockRoutinesRepository extends Mock implements RoutinesRepository {}

void main() {
  late MockRoutinesRepository repo;

  final fakePlan = Plan(
    id: 1,
    name: 'PPL',
    isActive: false,
    currentDayIndex: 0,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  setUp(() {
    repo = MockRoutinesRepository();
  });

  PlansCubit buildCubit() => PlansCubit(repo: repo);

  group('PlansCubit', () {
    blocTest<PlansCubit, PlansState>(
      'emits loading then loaded when watchPlans emits a list',
      setUp: () {
        when(() => repo.watchPlans()).thenAnswer(
          (_) => Stream.value(right([fakePlan])),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.init(),
      expect: () => [
        isA<PlansLoading>(),
        isA<PlansLoaded>(),
      ],
      verify: (cubit) {
        final loaded = cubit.state as PlansLoaded;
        expect(loaded.plans, [fakePlan]);
      },
    );

    blocTest<PlansCubit, PlansState>(
      'emits error when watchPlans emits a Failure',
      setUp: () {
        when(() => repo.watchPlans()).thenAnswer(
          (_) => Stream.value(
            left(const CacheFailure(message: 'db error')),
          ),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.init(),
      expect: () => [
        isA<PlansLoading>(),
        isA<PlansError>(),
      ],
    );

    blocTest<PlansCubit, PlansState>(
      'createPlan delegates to repo',
      setUp: () {
        when(() => repo.watchPlans()).thenAnswer((_) => const Stream.empty());
        when(() => repo.createPlan(any())).thenAnswer((_) => TaskEither.of(42));
      },
      build: buildCubit,
      act: (cubit) async {
        cubit.init();
        final result = await cubit.createPlan('Legs');
        expect(result.isRight(), isTrue);
      },
      expect: () => [isA<PlansLoading>()],
    );
  });
}
