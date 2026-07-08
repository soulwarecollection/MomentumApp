import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/enums/goal_type.dart';
import 'package:momentum/features/goals/domain/entities/goal.dart';
import 'package:momentum/features/goals/domain/entities/goal_progress.dart';
import 'package:momentum/features/goals/domain/repositories/goal_repository.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_cubit.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_state.dart';
import 'package:momentum/features/logging/domain/repositories/logging_repository.dart';
import 'package:momentum/features/weight/domain/repositories/weight_repository.dart';

class MockGoalRepository extends Mock implements GoalRepository {}

class MockWeightRepository extends Mock implements WeightRepository {}

class MockLoggingRepository extends Mock implements LoggingRepository {}

// ── Fixtures ──────────────────────────────────────────────────────────────

final _now = DateTime(2026, 6, 30);
final _deadline = DateTime(2026, 9, 30);

Goal _fatLossGoal({double startValue = 85}) => Goal(
  id: 1,
  type: GoalType.fatLoss,
  targetValue: 75,
  deadline: _deadline,
  createdAt: _now,
  startValue: startValue,
);

Goal _weightGainGoal() => Goal(
  id: 2,
  type: GoalType.weightGain,
  targetValue: 80,
  deadline: _deadline,
  createdAt: _now,
  startValue: 70,
);

Goal _strengthGoal() => Goal(
  id: 3,
  type: GoalType.strengthPr,
  targetValue: 120,
  deadline: _deadline,
  createdAt: _now,
  startValue: 100,
  exerciseName: 'Bench Press',
);

WeightEntryRow _weight(double kg) =>
    WeightEntryRow(id: 1, weightKg: kg, recordedAt: _now);

// ── Tests ─────────────────────────────────────────────────────────────────

void main() {
  setUpAll(() {
    registerFallbackValue(
      Goal(
        id: 0,
        type: GoalType.fatLoss,
        targetValue: 75,
        deadline: DateTime(2026, 9, 30),
        createdAt: DateTime(2026, 6, 30),
      ),
    );
  });

  late MockGoalRepository goalRepo;
  late MockWeightRepository weightRepo;
  late MockLoggingRepository loggingRepo;

  setUp(() {
    goalRepo = MockGoalRepository();
    weightRepo = MockWeightRepository();
    loggingRepo = MockLoggingRepository();
  });

  GoalCubit makeCubit() => GoalCubit(goalRepo, weightRepo, loggingRepo);

  group('GoalCubit', () {
    test('initial state is GoalLoading', () {
      expect(makeCubit().state, const GoalState.loading());
    });

    group('no active goal', () {
      blocTest<GoalCubit, GoalState>(
        'emits GoalNoGoal when watchActive emits null',
        build: () {
          when(
            () => goalRepo.watchActive(),
          ).thenAnswer((_) => Stream.value(null));
          return makeCubit();
        },
        act: (c) => c.init(),
        expect: () => [isA<GoalNoGoal>()],
      );
    });

    group('fat-loss goal', () {
      blocTest<GoalCubit, GoalState>(
        'emits GoalActive with weight progress when entries arrive',
        build: () {
          final goalCtrl = StreamController<Goal?>();
          final weightCtrl = StreamController<List<WeightEntryRow>>();
          when(() => goalRepo.watchActive()).thenAnswer((_) => goalCtrl.stream);
          when(
            () => weightRepo.watchAll(),
          ).thenAnswer((_) => weightCtrl.stream);
          goalCtrl.add(_fatLossGoal());
          weightCtrl.add([_weight(82)]);
          return makeCubit();
        },
        act: (c) => c.init(),
        expect: () => [
          isA<GoalActive>().having(
            (s) => s.progress.currentValue,
            'currentValue',
            82.0,
          ),
        ],
      );

      blocTest<GoalCubit, GoalState>(
        'progress fraction increases as weight drops toward target',
        build: () {
          final goalCtrl = StreamController<Goal?>();
          final weightCtrl = StreamController<List<WeightEntryRow>>();
          when(() => goalRepo.watchActive()).thenAnswer((_) => goalCtrl.stream);
          when(
            () => weightRepo.watchAll(),
          ).thenAnswer((_) => weightCtrl.stream);
          // start=85, target=75 → total delta=10; at 80 → 50% done
          goalCtrl.add(_fatLossGoal());
          weightCtrl.add([_weight(80)]);
          return makeCubit();
        },
        act: (c) => c.init(),
        expect: () => [
          isA<GoalActive>().having(
            (s) => s.progress.progressFraction,
            'progressFraction',
            closeTo(0.5, 0.01),
          ),
        ],
      );

      blocTest<GoalCubit, GoalState>(
        'isOnPace is true when fraction >= expected pace - tolerance',
        build: () {
          final goalCtrl = StreamController<Goal?>();
          final weightCtrl = StreamController<List<WeightEntryRow>>();
          when(() => goalRepo.watchActive()).thenAnswer((_) => goalCtrl.stream);
          when(
            () => weightRepo.watchAll(),
          ).thenAnswer((_) => weightCtrl.stream);
          // On day 0 (createdAt == now) expectedFraction ≈ 0;
          // any positive progress is on-pace.
          goalCtrl.add(_fatLossGoal());
          weightCtrl.add([_weight(84)]);
          return makeCubit();
        },
        act: (c) => c.init(),
        expect: () => [
          isA<GoalActive>().having(
            (s) => s.progress.isOnPace,
            'isOnPace',
            true,
          ),
        ],
      );
    });

    group('weight-gain goal', () {
      blocTest<GoalCubit, GoalState>(
        'progress fraction increases as weight rises toward target',
        build: () {
          final goalCtrl = StreamController<Goal?>();
          final weightCtrl = StreamController<List<WeightEntryRow>>();
          when(() => goalRepo.watchActive()).thenAnswer((_) => goalCtrl.stream);
          when(
            () => weightRepo.watchAll(),
          ).thenAnswer((_) => weightCtrl.stream);
          // start=70, target=80 → total=10; at 75 → 50%
          goalCtrl.add(_weightGainGoal());
          weightCtrl.add([_weight(75)]);
          return makeCubit();
        },
        act: (c) => c.init(),
        expect: () => [
          isA<GoalActive>().having(
            (s) => s.progress.progressFraction,
            'progressFraction',
            closeTo(0.5, 0.01),
          ),
        ],
      );
    });

    group('strength PR goal', () {
      blocTest<GoalCubit, GoalState>(
        'emits GoalActive with strength progress when 1RM is available',
        build: () {
          when(
            () => goalRepo.watchActive(),
          ).thenAnswer((_) => Stream.value(_strengthGoal()));
          when(
            () => loggingRepo.getBestOneRepMax('Bench Press'),
          ).thenReturn(TaskEither.right(110));
          return makeCubit();
        },
        act: (c) => c.init(),
        expect: () => [
          isA<GoalActive>().having(
            (s) => s.progress.currentValue,
            'currentValue',
            110.0,
          ),
        ],
      );

      blocTest<GoalCubit, GoalState>(
        'falls back to startValue when no 1RM history exists',
        build: () {
          when(
            () => goalRepo.watchActive(),
          ).thenAnswer((_) => Stream.value(_strengthGoal()));
          when(
            () => loggingRepo.getBestOneRepMax('Bench Press'),
          ).thenReturn(TaskEither.right(null));
          return makeCubit();
        },
        act: (c) => c.init(),
        expect: () => [
          isA<GoalActive>().having(
            (s) => s.progress.currentValue,
            'currentValue',
            100.0,
          ),
        ],
      );
    });

    group('stall detection', () {
      blocTest<GoalCubit, GoalState>(
        'emits checkCalories suggestion when 5 entries spread <= 0.5 kg '
        'and not on pace',
        build: () {
          // Create a goal where createdAt is far in the past so
          // expectedFraction is high and current fraction is low →
          // isOnPace = false.
          final staleGoal = Goal(
            id: 1,
            type: GoalType.fatLoss,
            targetValue: 70,
            deadline: DateTime(2026, 12, 31),
            createdAt: DateTime(2025),
            startValue: 90,
          );
          final goalCtrl = StreamController<Goal?>();
          final weightCtrl = StreamController<List<WeightEntryRow>>();
          when(() => goalRepo.watchActive()).thenAnswer((_) => goalCtrl.stream);
          when(
            () => weightRepo.watchAll(),
          ).thenAnswer((_) => weightCtrl.stream);
          goalCtrl.add(staleGoal);
          // 5 entries all at ~88 kg → spread ≈ 0 ≤ 0.5 and we're behind
          weightCtrl.add(
            List.generate(
              5,
              (i) => WeightEntryRow(
                id: i + 1,
                weightKg: 88 + i * 0.1,
                recordedAt: _now,
              ),
            ),
          );
          return makeCubit();
        },
        act: (c) => c.init(),
        expect: () => [
          isA<GoalActive>().having(
            (s) => s.progress.suggestion,
            'suggestion',
            GoalSuggestion.checkCalories,
          ),
        ],
      );

      blocTest<GoalCubit, GoalState>(
        'no stall suggestion when fewer than 5 weight entries',
        build: () {
          final goalCtrl = StreamController<Goal?>();
          final weightCtrl = StreamController<List<WeightEntryRow>>();
          when(() => goalRepo.watchActive()).thenAnswer((_) => goalCtrl.stream);
          when(
            () => weightRepo.watchAll(),
          ).thenAnswer((_) => weightCtrl.stream);
          goalCtrl.add(_fatLossGoal());
          weightCtrl.add([_weight(84), _weight(84), _weight(84)]);
          return makeCubit();
        },
        act: (c) => c.init(),
        expect: () => [
          isA<GoalActive>().having(
            (s) => s.progress.suggestion,
            'suggestion',
            isNull,
          ),
        ],
      );
    });

    group('setGoal / clearGoal', () {
      test('delegates setGoal to repository', () async {
        when(
          () => goalRepo.watchActive(),
        ).thenAnswer((_) => const Stream.empty());
        when(() => goalRepo.setGoal(any())).thenAnswer((_) async {});
        final cubit = makeCubit()..init();
        await cubit.setGoal(_fatLossGoal());
        verify(() => goalRepo.setGoal(any())).called(1);
        await cubit.close();
      });

      test('delegates clearGoal to repository', () async {
        when(
          () => goalRepo.watchActive(),
        ).thenAnswer((_) => const Stream.empty());
        when(() => goalRepo.clearGoal()).thenAnswer((_) async {});
        final cubit = makeCubit()..init();
        await cubit.clearGoal();
        verify(() => goalRepo.clearGoal()).called(1);
        await cubit.close();
      });
    });
  });
}
