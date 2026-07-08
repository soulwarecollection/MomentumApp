import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/weight/domain/repositories/weight_repository.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_cubit.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_state.dart';

class MockWeightRepository extends Mock implements WeightRepository {}

// ── Fixtures ─────────────────────────────────────────────────────────────────

final _now = DateTime(2026, 6, 30, 9);

WeightEntryRow _row(int id, double kg) => WeightEntryRow(
  id: id,
  weightKg: kg,
  recordedAt: _now,
);

// ── Tests ────────────────────────────────────────────────────────────────────

void main() {
  late MockWeightRepository repo;

  setUp(() {
    repo = MockWeightRepository();
  });

  WeightCubit makeCubit() => WeightCubit(repo);

  group('WeightCubit', () {
    test('initial state is WeightLoading', () {
      expect(makeCubit().state, const WeightState.loading());
    });

    group('init()', () {
      blocTest<WeightCubit, WeightState>(
        'emits WeightReady with entries after streams fire',
        build: () {
          final rows = [_row(1, 80.5), _row(2, 79)];
          final allCtrl = StreamController<List<WeightEntryRow>>();
          final chartCtrl = StreamController<List<WeightEntryRow>>();
          when(() => repo.watchAll()).thenAnswer((_) => allCtrl.stream);
          when(
            () => repo.watchLast90Days(),
          ).thenAnswer((_) => chartCtrl.stream);
          scheduleMicrotask(() {
            allCtrl.add(rows);
            chartCtrl.add(rows.reversed.toList());
          });
          return makeCubit();
        },
        act: (cubit) => cubit.init(),
        expect: () => [
          // allCtrl fires first → chartPoints still empty
          WeightState.ready(
            entries: [_row(1, 80.5), _row(2, 79)],
            chartPoints: const [],
            latest: _row(1, 80.5),
          ),
          // chartCtrl fires second → full state
          WeightState.ready(
            entries: [_row(1, 80.5), _row(2, 79)],
            chartPoints: [_row(2, 79), _row(1, 80.5)],
            latest: _row(1, 80.5),
          ),
        ],
        wait: const Duration(milliseconds: 50),
      );

      blocTest<WeightCubit, WeightState>(
        'emits WeightError on stream error',
        build: () {
          final errCtrl = StreamController<List<WeightEntryRow>>();
          final chartCtrl = StreamController<List<WeightEntryRow>>();
          when(() => repo.watchAll()).thenAnswer((_) => errCtrl.stream);
          when(
            () => repo.watchLast90Days(),
          ).thenAnswer((_) => chartCtrl.stream);
          scheduleMicrotask(
            () => errCtrl.addError(Exception('db failure')),
          );
          return makeCubit();
        },
        act: (cubit) => cubit.init(),
        expect: () => [isA<WeightError>()],
        wait: const Duration(milliseconds: 50),
      );
    });

    group('add()', () {
      blocTest<WeightCubit, WeightState>(
        'calls repository addEntry with no note',
        build: () {
          when(() => repo.watchAll()).thenAnswer((_) => const Stream.empty());
          when(
            () => repo.watchLast90Days(),
          ).thenAnswer((_) => const Stream.empty());
          when(
            () => repo.addEntry(weightKg: 82),
          ).thenAnswer((_) async {});
          return makeCubit()..init();
        },
        act: (cubit) => cubit.add(82),
        verify: (_) => verify(() => repo.addEntry(weightKg: 82)).called(1),
      );

      blocTest<WeightCubit, WeightState>(
        'passes note when provided',
        build: () {
          when(() => repo.watchAll()).thenAnswer((_) => const Stream.empty());
          when(
            () => repo.watchLast90Days(),
          ).thenAnswer((_) => const Stream.empty());
          when(
            () => repo.addEntry(weightKg: 75.5, note: 'morning'),
          ).thenAnswer((_) async {});
          return makeCubit()..init();
        },
        act: (cubit) => cubit.add(75.5, note: 'morning'),
        verify: (_) => verify(
          () => repo.addEntry(weightKg: 75.5, note: 'morning'),
        ).called(1),
      );
    });

    group('delete()', () {
      blocTest<WeightCubit, WeightState>(
        'calls repository deleteEntry',
        build: () {
          when(() => repo.watchAll()).thenAnswer((_) => const Stream.empty());
          when(
            () => repo.watchLast90Days(),
          ).thenAnswer((_) => const Stream.empty());
          when(() => repo.deleteEntry(7)).thenAnswer((_) async {});
          return makeCubit()..init();
        },
        act: (cubit) => cubit.delete(7),
        verify: (_) => verify(() => repo.deleteEntry(7)).called(1),
      );
    });

    test('close() cancels subscriptions without throwing', () async {
      when(() => repo.watchAll()).thenAnswer((_) => const Stream.empty());
      when(
        () => repo.watchLast90Days(),
      ).thenAnswer((_) => const Stream.empty());
      final cubit = makeCubit()..init();
      await expectLater(cubit.close(), completes);
    });
  });
}
