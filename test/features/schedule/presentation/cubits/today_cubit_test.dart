import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/schedule/domain/entities/schedule_override.dart';
import 'package:momentum/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:momentum/features/schedule/presentation/cubits/today_cubit.dart';
import 'package:momentum/features/schedule/presentation/cubits/today_state.dart';

class MockRoutinesRepository extends Mock implements RoutinesRepository {}

class MockScheduleRepository extends Mock implements ScheduleRepository {}

// ── Fixtures ─────────────────────────────────────────────────────────────────

final _now = DateTime(2026, 6, 26);

final _plan = Plan(
  id: 1,
  name: 'PPL',
  isActive: true,
  currentDayIndex: 0,
  createdAt: _now,
  updatedAt: _now,
);

final _plan2 = Plan(
  id: 2,
  name: 'Bro Split',
  isActive: false,
  currentDayIndex: 0,
  createdAt: _now,
  updatedAt: _now,
);

const _days = [
  PlanDay(id: 10, planId: 1, orderIndex: 0, isRest: false, focus: 'Push'),
  PlanDay(id: 11, planId: 1, orderIndex: 1, isRest: false, focus: 'Pull'),
  PlanDay(id: 12, planId: 1, orderIndex: 2, isRest: true),
];

const _exercises = [
  PlanExercise(id: 100, planDayId: 10, orderIndex: 0, name: 'Bench Press'),
];

// ── Helper ───────────────────────────────────────────────────────────────────

class _StreamPair<T> {
  final _controller = StreamController<Either<Failure, T>>.broadcast();

  Stream<Either<Failure, T>> get stream => _controller.stream;

  void add(Either<Failure, T> event) => _controller.add(event);

  Future<void> close() => _controller.close();
}

// ── Tests ────────────────────────────────────────────────────────────────────

void main() {
  late MockRoutinesRepository routinesRepo;
  late MockScheduleRepository scheduleRepo;

  late _StreamPair<List<Plan>> plansStream;
  late _StreamPair<List<PlanDay>> daysStream;
  late _StreamPair<List<PlanExercise>> exStream;

  setUp(() {
    routinesRepo = MockRoutinesRepository();
    scheduleRepo = MockScheduleRepository();

    plansStream = _StreamPair();
    daysStream = _StreamPair();
    exStream = _StreamPair();

    when(() => routinesRepo.watchPlans()).thenAnswer((_) => plansStream.stream);
    when(
      () => routinesRepo.watchPlanDays(any()),
    ).thenAnswer((_) => daysStream.stream);
    when(
      () => routinesRepo.watchAllExercisesForPlan(any()),
    ).thenAnswer((_) => exStream.stream);

    when(() => scheduleRepo.getOverride()).thenReturn(null);
    when(
      () => scheduleRepo.overrideChanges,
    ).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() async {
    await plansStream.close();
    await daysStream.close();
    await exStream.close();
  });

  TodayCubit buildCubit() => TodayCubit(
    routinesRepo: routinesRepo,
    scheduleRepo: scheduleRepo,
  )..init();

  group('TodayCubit', () {
    blocTest<TodayCubit, TodayState>(
      'starts as loading and emits nothing until a stream fires',
      build: buildCubit,
      expect: () => <TodayState>[],
    );

    blocTest<TodayCubit, TodayState>(
      'emits noActivePlan when plans list is empty',
      build: buildCubit,
      act: (_) => plansStream.add(const Right([])),
      expect: () => [const TodayState.noActivePlan()],
    );

    blocTest<TodayCubit, TodayState>(
      'emits ready after plans, days, and exercises arrive',
      build: buildCubit,
      act: (_) async {
        plansStream.add(Right([_plan]));
        await Future<void>.delayed(Duration.zero);
        daysStream.add(const Right(_days));
        exStream.add(const Right(_exercises));
      },
      expect: () => [
        isA<TodayReady>()
            .having((s) => s.nextWorkout.day.focus, 'day focus', 'Push')
            .having(
              (s) => s.nextWorkout.exercises,
              'exercises',
              hasLength(1),
            ),
      ],
    );

    blocTest<TodayCubit, TodayState>(
      'emits error when watchPlans fails',
      build: buildCubit,
      act: (_) =>
          plansStream.add(const Left(CacheFailure(message: 'db error'))),
      expect: () => [isA<TodayError>()],
    );

    blocTest<TodayCubit, TodayState>(
      'respects schedule override — tracks override plan instead of active',
      setUp: () {
        when(() => scheduleRepo.getOverride()).thenReturn(
          const ScheduleOverride(planId: 2, dayIndex: 0),
        );
        when(
          () => routinesRepo.watchPlanDays(2),
        ).thenAnswer((_) => daysStream.stream);
        when(
          () => routinesRepo.watchAllExercisesForPlan(2),
        ).thenAnswer((_) => exStream.stream);
      },
      build: buildCubit,
      act: (_) async {
        plansStream.add(Right([_plan, _plan2]));
        await Future<void>.delayed(Duration.zero);
        daysStream.add(
          const Right([
            PlanDay(
              id: 20,
              planId: 2,
              orderIndex: 0,
              isRest: false,
              focus: 'Chest',
            ),
          ]),
        );
        exStream.add(const Right([]));
      },
      expect: () => [
        isA<TodayReady>().having(
          (s) => s.nextWorkout.plan.name,
          'plan name',
          'Bro Split',
        ),
      ],
    );

    blocTest<TodayCubit, TodayState>(
      'noActivePlan when days list is empty',
      build: buildCubit,
      act: (_) async {
        plansStream.add(Right([_plan]));
        await Future<void>.delayed(Duration.zero);
        daysStream.add(const Right([]));
        exStream.add(const Right([]));
      },
      expect: () => [const TodayState.noActivePlan()],
    );
  });
}
