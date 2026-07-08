import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/logging/domain/entities/exercise_entry.dart';
import 'package:momentum/features/logging/domain/entities/set_row.dart';
import 'package:momentum/features/logging/domain/repositories/logging_repository.dart';
import 'package:momentum/features/logging/presentation/bloc/session_bloc.dart';
import 'package:momentum/features/logging/presentation/bloc/session_event.dart';
import 'package:momentum/features/logging/presentation/bloc/session_state.dart';

class MockLoggingRepository extends Mock implements LoggingRepository {}

void main() {
  late MockLoggingRepository repo;

  const sessionId = 42;

  const benchEntry = ExerciseEntry(
    localId: 'ex1',
    name: 'Bench Press',
    modality: Modality.strength,
    sets: [
      SetRow(
        localId: 's1',
        metrics: {'weight': 80, 'reps': 8},
      ),
    ],
  );

  const startedEvent = SessionEvent.started(
    exercises: [benchEntry],
  );

  setUp(() {
    repo = MockLoggingRepository();
    registerFallbackValue(benchEntry);
    registerFallbackValue(
      const SessionEvent.started(exercises: []),
    );
  });

  void stubCreateSession() {
    when(
      () => repo.createSession(
        planId: any(named: 'planId'),
        dayIndex: any(named: 'dayIndex'),
        focus: any(named: 'focus'),
      ),
    ).thenAnswer((_) => TaskEither.of(sessionId));
  }

  SessionBloc buildBloc() => SessionBloc(repo: repo);

  group('SessionBloc', () {
    blocTest<SessionBloc, SessionState>(
      'started emits active with sessionId',
      setUp: stubCreateSession,
      build: buildBloc,
      act: (bloc) => bloc.add(startedEvent),
      expect: () => [
        isA<SessionActive>().having((s) => s.sessionId, 'sessionId', sessionId),
      ],
    );

    blocTest<SessionBloc, SessionState>(
      'started emits error when createSession fails',
      setUp: () {
        when(
          () => repo.createSession(
            planId: any(named: 'planId'),
            dayIndex: any(named: 'dayIndex'),
            focus: any(named: 'focus'),
          ),
        ).thenAnswer(
          (_) => TaskEither.left(
            const CacheFailure(message: 'db error'),
          ),
        );
      },
      build: buildBloc,
      act: (bloc) => bloc.add(startedEvent),
      expect: () => [isA<SessionError>()],
    );

    blocTest<SessionBloc, SessionState>(
      'setRowValue updates metric in matching set',
      setUp: stubCreateSession,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(startedEvent);
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const SessionEvent.setRowValue(
            exerciseLocalId: 'ex1',
            setLocalId: 's1',
            metricKey: 'weight',
            value: 100,
          ),
        );
      },
      verify: (bloc) {
        final s = bloc.state as SessionActive;
        expect(s.exercises.first.sets.first.metrics['weight'], 100.0);
      },
    );

    blocTest<SessionBloc, SessionState>(
      'stepRowValue clamps at 0',
      setUp: stubCreateSession,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(startedEvent);
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const SessionEvent.stepRowValue(
            exerciseLocalId: 'ex1',
            setLocalId: 's1',
            metricKey: 'reps',
            delta: -100,
          ),
        );
      },
      verify: (bloc) {
        final s = bloc.state as SessionActive;
        expect(
          s.exercises.first.sets.first.metrics['reps'],
          0.0,
        );
      },
    );

    blocTest<SessionBloc, SessionState>(
      'setAdded copies metrics from previous set',
      setUp: stubCreateSession,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(startedEvent);
        await Future<void>.delayed(Duration.zero);
        bloc.add(const SessionEvent.setAdded('ex1'));
      },
      verify: (bloc) {
        final s = bloc.state as SessionActive;
        final sets = s.exercises.first.sets;
        expect(sets, hasLength(2));
        expect(sets[1].metrics['weight'], 80.0);
        expect(sets[1].metrics['reps'], 8.0);
      },
    );

    blocTest<SessionBloc, SessionState>(
      'setRemoved removes the set',
      setUp: stubCreateSession,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(startedEvent);
        await Future<void>.delayed(Duration.zero);
        bloc.add(const SessionEvent.setAdded('ex1'));
        await Future<void>.delayed(Duration.zero);
        final s = bloc.state as SessionActive;
        final secondSetId = s.exercises.first.sets[1].localId;
        bloc.add(
          SessionEvent.setRemoved(
            exerciseLocalId: 'ex1',
            setLocalId: secondSetId,
          ),
        );
      },
      verify: (bloc) {
        final s = bloc.state as SessionActive;
        expect(s.exercises.first.sets, hasLength(1));
      },
    );

    blocTest<SessionBloc, SessionState>(
      'exerciseReordered swaps exercises',
      setUp: stubCreateSession,
      build: buildBloc,
      act: (bloc) async {
        const secondEntry = ExerciseEntry(
          localId: 'ex2',
          name: 'Squat',
          modality: Modality.strength,
          sets: [
            SetRow(
              localId: 's2',
              metrics: {'weight': 100, 'reps': 5},
            ),
          ],
        );
        bloc.add(
          const SessionEvent.started(
            exercises: [benchEntry, secondEntry],
          ),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const SessionEvent.exerciseReordered(
            oldIndex: 0,
            newIndex: 2,
          ),
        );
      },
      verify: (bloc) {
        final s = bloc.state as SessionActive;
        expect(s.exercises.first.name, 'Squat');
        expect(s.exercises[1].name, 'Bench Press');
      },
    );

    blocTest<SessionBloc, SessionState>(
      'rowToggled marks done and starts rest timer',
      setUp: () {
        stubCreateSession();
        when(
          () => repo.getBestOneRepMax(any()),
        ).thenAnswer((_) => TaskEither.of(null));
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(startedEvent);
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const SessionEvent.rowToggled(
            exerciseLocalId: 'ex1',
            setLocalId: 's1',
          ),
        );
        await Future<void>.delayed(Duration.zero);
      },
      verify: (bloc) {
        final s = bloc.state as SessionActive;
        expect(s.exercises.first.sets.first.isDone, isTrue);
        expect(s.restSecondsLeft, isNotNull);
      },
    );

    blocTest<SessionBloc, SessionState>(
      'PR detected: celebrationExercise set when new best',
      setUp: () {
        stubCreateSession();
        // getBestOneRepMax returns null (no history) → current set is a PR
        when(
          () => repo.getBestOneRepMax(any()),
        ).thenAnswer((_) => TaskEither.of(null));
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(startedEvent);
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const SessionEvent.rowToggled(
            exerciseLocalId: 'ex1',
            setLocalId: 's1',
          ),
        );
        await Future<void>.delayed(Duration.zero);
      },
      verify: (bloc) {
        final s = bloc.state as SessionActive;
        expect(s.celebrationExercise, 'Bench Press');
        expect(s.exercises.first.isPrHighlighted, isTrue);
      },
    );

    blocTest<SessionBloc, SessionState>(
      'no PR: celebrationExercise null when below best',
      setUp: () {
        stubCreateSession();
        // 80kg × 8 reps → Epley 1RM ≈ 101.3. Return 120 (higher historical)
        when(
          () => repo.getBestOneRepMax(any()),
        ).thenAnswer((_) => TaskEither.of(120));
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(startedEvent);
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const SessionEvent.rowToggled(
            exerciseLocalId: 'ex1',
            setLocalId: 's1',
          ),
        );
        await Future<void>.delayed(Duration.zero);
      },
      verify: (bloc) {
        final s = bloc.state as SessionActive;
        expect(s.celebrationExercise, isNull);
      },
    );

    blocTest<SessionBloc, SessionState>(
      'exercisePreFilled fills only untouched sets, without starting '
      'the stopwatch',
      setUp: stubCreateSession,
      build: buildBloc,
      act: (bloc) async {
        const entry = ExerciseEntry(
          localId: 'ex1',
          name: 'Squat',
          modality: Modality.strength,
          sets: [
            SetRow(localId: 's1', metrics: {'weight': 0, 'reps': 0}),
            SetRow(localId: 's2', metrics: {'weight': 50, 'reps': 5}),
          ],
        );
        bloc.add(const SessionEvent.started(exercises: [entry]));
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const SessionEvent.exercisePreFilled(
            exerciseLocalId: 'ex1',
            setMetrics: [
              {'weight': 100, 'reps': 8},
              {'weight': 90, 'reps': 6},
            ],
          ),
        );
      },
      verify: (bloc) {
        final s = bloc.state as SessionActive;
        final sets = s.exercises.first.sets;
        expect(sets[0].metrics, {'weight': 100.0, 'reps': 8.0});
        expect(sets[1].metrics, {'weight': 50.0, 'reps': 5.0});
        expect(s.stopwatchRunning, isFalse);
        expect(s.stopwatchStartedAt, isNull);
      },
    );

    blocTest<SessionBloc, SessionState>(
      'finishRequested saves session and emits finished',
      setUp: () {
        stubCreateSession();
        when(
          () => repo.finishSession(
            sessionId: any(named: 'sessionId'),
            endedAt: any(named: 'endedAt'),
            durationSeconds: any(named: 'durationSeconds'),
            exercises: any(named: 'exercises'),
            planId: any(named: 'planId'),
            dayIndex: any(named: 'dayIndex'),
          ),
        ).thenAnswer((_) => TaskEither.of(unit));
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(startedEvent);
        await Future<void>.delayed(Duration.zero);
        bloc.add(const SessionEvent.finishRequested());
      },
      expect: () => [
        isA<SessionActive>(),
        isA<SessionSaving>(),
        isA<SessionFinished>(),
      ],
    );
  });
}
