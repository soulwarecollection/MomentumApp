import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/schedule/domain/entities/schedule_override.dart';
import 'package:momentum/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:momentum/features/schedule/presentation/cubits/scheduler_cubit.dart';
import 'package:momentum/features/schedule/presentation/cubits/scheduler_state.dart';

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

const _days = [
  PlanDay(id: 10, planId: 1, orderIndex: 0, isRest: false, focus: 'Push'),
  PlanDay(id: 11, planId: 1, orderIndex: 1, isRest: false, focus: 'Pull'),
  PlanDay(id: 12, planId: 1, orderIndex: 2, isRest: true),
];

// ── Tests ────────────────────────────────────────────────────────────────────

void main() {
  late MockRoutinesRepository routinesRepo;
  late MockScheduleRepository scheduleRepo;

  setUp(() {
    routinesRepo = MockRoutinesRepository();
    scheduleRepo = MockScheduleRepository();

    when(
      () => routinesRepo.watchPlans(),
    ).thenAnswer((_) => Stream.value(Right([_plan])));
    when(
      () => routinesRepo.watchPlanDays(any()),
    ).thenAnswer((_) => Stream.value(const Right(_days)));
    when(() => scheduleRepo.getOverride()).thenReturn(null);
  });

  SchedulerCubit buildCubit() => SchedulerCubit(
    routinesRepo: routinesRepo,
    scheduleRepo: scheduleRepo,
  );

  group('SchedulerCubit', () {
    blocTest<SchedulerCubit, SchedulerState>(
      'init emits ready with active plan and currentDayIndex',
      build: buildCubit,
      act: (c) => c.init(),
      expect: () => [
        isA<SchedulerReady>()
            .having((s) => s.selectedPlanId, 'plan', 1)
            .having((s) => s.selectedDayIndex, 'dayIndex', 0)
            .having((s) => s.selectedPlanDays, 'days', hasLength(3)),
      ],
    );

    blocTest<SchedulerCubit, SchedulerState>(
      'init pre-selects override day when override exists',
      setUp: () {
        when(() => scheduleRepo.getOverride()).thenReturn(
          const ScheduleOverride(planId: 1, dayIndex: 1),
        );
      },
      build: buildCubit,
      act: (c) => c.init(),
      expect: () => [
        isA<SchedulerReady>().having(
          (s) => s.selectedDayIndex,
          'dayIndex',
          1,
        ),
      ],
    );

    blocTest<SchedulerCubit, SchedulerState>(
      'changeDay updates selectedDayIndex',
      build: buildCubit,
      act: (c) async {
        await c.init();
        c.changeDay(2);
      },
      expect: () => [
        isA<SchedulerReady>(),
        isA<SchedulerReady>().having(
          (s) => s.selectedDayIndex,
          'dayIndex',
          2,
        ),
      ],
    );

    blocTest<SchedulerCubit, SchedulerState>(
      'changeDate sets scheduledDate',
      build: buildCubit,
      act: (c) async {
        await c.init();
        c.changeDate(DateTime(2026, 7, 4));
      },
      expect: () => [
        isA<SchedulerReady>(),
        isA<SchedulerReady>().having(
          (s) => s.scheduledDate,
          'scheduledDate',
          DateTime(2026, 7, 4),
        ),
      ],
    );

    blocTest<SchedulerCubit, SchedulerState>(
      'changeDate(null) clears scheduledDate',
      build: buildCubit,
      act: (c) async {
        await c.init();
        c
          ..changeDate(DateTime(2026, 7, 4))
          ..changeDate(null);
      },
      verify: (c) {
        final s = c.state as SchedulerReady;
        expect(s.scheduledDate, isNull);
      },
    );

    blocTest<SchedulerCubit, SchedulerState>(
      'save calls setOverride with current selection',
      setUp: () {
        when(
          () => scheduleRepo.setOverride(
            planId: any(named: 'planId'),
            dayIndex: any(named: 'dayIndex'),
            scheduledDate: any(named: 'scheduledDate'),
          ),
        ).thenAnswer((_) async {});
      },
      build: buildCubit,
      act: (c) async {
        await c.init();
        await (c..changeDay(1)).save();
      },
      verify: (_) {
        verify(
          () => scheduleRepo.setOverride(
            planId: 1,
            dayIndex: 1,
          ),
        ).called(1);
      },
    );

    blocTest<SchedulerCubit, SchedulerState>(
      'emits error when no plans available',
      setUp: () {
        when(
          () => routinesRepo.watchPlans(),
        ).thenAnswer((_) => Stream.value(const Right([])));
      },
      build: buildCubit,
      act: (c) => c.init(),
      expect: () => [isA<SchedulerError>()],
    );
  });
}
