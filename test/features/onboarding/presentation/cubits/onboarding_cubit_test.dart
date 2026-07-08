import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/onboarding/domain/entities/onboarding_focus.dart';
import 'package:momentum/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:momentum/features/onboarding/presentation/cubits/onboarding_cubit.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';

class MockRoutinesRepository extends Mock implements RoutinesRepository {}

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late MockRoutinesRepository routinesRepo;
  late MockOnboardingRepository onboardingRepo;

  setUp(() {
    routinesRepo = MockRoutinesRepository();
    onboardingRepo = MockOnboardingRepository();
  });

  OnboardingCubit buildCubit() => OnboardingCubit(routinesRepo, onboardingRepo);

  group('OnboardingCubit navigation', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'nextStep skips the split step for cardio focus',
      build: buildCubit,
      act: (cubit) {
        cubit
          ..selectFocus(OnboardingFocus.cardio)
          ..nextStep() // welcome -> focus
          ..nextStep(); // focus -> confirm (split skipped)
      },
      verify: (cubit) => expect(cubit.state.step, 3),
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'nextStep visits the split step for strength focus',
      build: buildCubit,
      act: (cubit) {
        cubit
          ..nextStep() // welcome -> focus
          ..nextStep(); // focus -> split
      },
      verify: (cubit) => expect(cubit.state.step, 2),
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'back mirrors the cardio skip',
      build: buildCubit,
      act: (cubit) {
        cubit
          ..selectFocus(OnboardingFocus.cardio)
          ..nextStep()
          ..nextStep()
          ..back();
      },
      verify: (cubit) => expect(cubit.state.step, 1),
    );
  });

  group('OnboardingCubit confirmAndCreatePlan', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'creates days/exercises, activates the plan, and marks onboarded',
      setUp: () {
        when(
          () => routinesRepo.createPlan(any()),
        ).thenAnswer((_) => TaskEither.of(1));
        when(
          () => routinesRepo.addDay(
            any(),
            isRest: any(named: 'isRest'),
            focus: any(named: 'focus'),
          ),
        ).thenAnswer((_) => TaskEither.of(10));
        when(
          () => routinesRepo.addExercise(
            any(),
            name: any(named: 'name'),
            equipment: any(named: 'equipment'),
            targetSets: any(named: 'targetSets'),
          ),
        ).thenAnswer((_) => TaskEither.of(100));
        when(
          () => routinesRepo.setActivePlan(any()),
        ).thenAnswer((_) => TaskEither.of(unit));
        when(
          () => onboardingRepo.completeOnboarding(
            justOnboarded: any(named: 'justOnboarded'),
          ),
        ).thenAnswer((_) async {});
      },
      build: buildCubit,
      act: (cubit) => cubit.confirmAndCreatePlan(),
      verify: (cubit) {
        expect(cubit.state.isSaving, isFalse);
        expect(cubit.state.error, isNull);
        verify(() => routinesRepo.createPlan(any())).called(1);
        verify(() => routinesRepo.setActivePlan(1)).called(1);
        verify(
          () => onboardingRepo.completeOnboarding(justOnboarded: true),
        ).called(1);
        // Default state is strength focus / 4-day split -> Upper/Lower x2.
        verify(
          () => routinesRepo.addDay(
            1,
            isRest: false,
            focus: any(named: 'focus'),
          ),
        ).called(4);
      },
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'sets an error and does not touch onboarding state if createPlan fails',
      setUp: () {
        when(() => routinesRepo.createPlan(any())).thenAnswer(
          (_) => TaskEither.left(const CacheFailure(message: 'db error')),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.confirmAndCreatePlan(),
      verify: (cubit) {
        expect(cubit.state.isSaving, isFalse);
        expect(cubit.state.error, isNotNull);
        verifyNever(() => routinesRepo.setActivePlan(any()));
        verifyNever(
          () => onboardingRepo.completeOnboarding(
            justOnboarded: any(named: 'justOnboarded'),
          ),
        );
      },
    );
  });
}
