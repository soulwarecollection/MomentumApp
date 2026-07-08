import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/library/domain/entities/exercise.dart';
import 'package:momentum/features/library/domain/repositories/library_repository.dart';
import 'package:momentum/features/library/presentation/cubits/library_cubit.dart';
import 'package:momentum/features/library/presentation/cubits/library_state.dart';

class _MockLibraryRepository extends Mock implements LibraryRepository {}

// Helpers
Exercise _ex(int id, String name, Modality modality) => Exercise(
  id: id,
  name: name,
  modality: modality,
);

final Exercise _benchPress = _ex(1, 'Bench Press', Modality.strength);
final Exercise _squat = _ex(2, 'Squat', Modality.strength);
final Exercise _running = _ex(3, 'Running', Modality.cardio);
final Exercise _pushUp = _ex(4, 'Push-Up', Modality.bodyweight);
final List<Exercise> _allExercises = [_benchPress, _pushUp, _running, _squat];

void main() {
  late _MockLibraryRepository repo;

  setUp(() {
    repo = _MockLibraryRepository();
  });

  group('LibraryCubit', () {
    test('initial state is loading', () {
      when(
        () => repo.watchExercises(
          query: any(named: 'query'),
          modality: any(named: 'modality'),
        ),
      ).thenAnswer((_) => const Stream.empty());
      expect(
        LibraryCubit(repo).state,
        const LibraryState.loading(),
      );
    });

    blocTest<LibraryCubit, LibraryState>(
      'emits ready with all exercises on load',
      build: () {
        when(
          () => repo.watchExercises(
            query: any(named: 'query'),
            modality: any(named: 'modality'),
          ),
        ).thenAnswer((_) => Stream.value(_allExercises));
        return LibraryCubit(repo);
      },
      act: (c) => c.load(),
      expect: () => [
        LibraryState.ready(exercises: _allExercises),
      ],
    );

    blocTest<LibraryCubit, LibraryState>(
      'emits ready with query when setQuery called',
      build: () {
        when(
          () => repo.watchExercises(
            query: any(named: 'query'),
            modality: any(named: 'modality'),
          ),
        ).thenAnswer((_) => Stream.value(_allExercises));
        return LibraryCubit(repo);
      },
      act: (c) async {
        c.load();
        await Future<void>.delayed(Duration.zero);
        c.setQuery('bench');
      },
      expect: () => [
        LibraryState.ready(exercises: _allExercises),
        LibraryState.ready(exercises: _allExercises, query: 'bench'),
      ],
    );

    blocTest<LibraryCubit, LibraryState>(
      'emits ready with selectedModality when setModality called',
      build: () {
        when(
          () => repo.watchExercises(
            query: any(named: 'query'),
            modality: any(named: 'modality'),
          ),
        ).thenAnswer((_) => Stream.value(_allExercises));
        return LibraryCubit(repo);
      },
      act: (c) async {
        c.load();
        await Future<void>.delayed(Duration.zero);
        c.setModality(Modality.strength);
      },
      expect: () => [
        LibraryState.ready(exercises: _allExercises),
        LibraryState.ready(
          exercises: _allExercises,
          selectedModality: Modality.strength,
        ),
      ],
    );

    blocTest<LibraryCubit, LibraryState>(
      'clears modality filter when setModality(null) called',
      build: () {
        when(
          () => repo.watchExercises(
            query: any(named: 'query'),
            modality: any(named: 'modality'),
          ),
        ).thenAnswer((_) => Stream.value(_allExercises));
        return LibraryCubit(repo);
      },
      act: (c) async {
        c.load();
        await Future<void>.delayed(Duration.zero);
        c.setModality(Modality.cardio);
        await Future<void>.delayed(Duration.zero);
        c.setModality(null);
      },
      expect: () => [
        LibraryState.ready(exercises: _allExercises),
        LibraryState.ready(
          exercises: _allExercises,
          selectedModality: Modality.cardio,
        ),
        LibraryState.ready(exercises: _allExercises),
      ],
    );

    blocTest<LibraryCubit, LibraryState>(
      'emits error when stream errors',
      build: () {
        when(
          () => repo.watchExercises(
            query: any(named: 'query'),
            modality: any(named: 'modality'),
          ),
        ).thenAnswer(
          (_) => Stream.error(Exception('db error')),
        );
        return LibraryCubit(repo);
      },
      act: (c) => c.load(),
      expect: () => [
        isA<LibraryError>(),
      ],
    );

    blocTest<LibraryCubit, LibraryState>(
      'emits ready with empty list when no exercises',
      build: () {
        when(
          () => repo.watchExercises(
            query: any(named: 'query'),
            modality: any(named: 'modality'),
          ),
        ).thenAnswer((_) => Stream.value([]));
        return LibraryCubit(repo);
      },
      act: (c) => c.load(),
      expect: () => [
        const LibraryState.ready(exercises: []),
      ],
    );
  });
}
