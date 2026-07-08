import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/usecases/compute_weekly_volume.dart';

void main() {
  const usecase = ComputeWeeklyVolume();

  // Jun 1 and Jun 8 are both Mondays (weekday=1) in 2026
  final june1 = DateTime(2026, 6);
  final june8 = DateTime(2026, 6, 8);

  RawSet strength({
    required DateTime date,
    required double weight,
    required double reps,
    int sessionId = 1,
  }) => RawSet(
    sessionId: sessionId,
    exerciseName: 'Squat',
    modality: Modality.strength,
    sessionDate: date,
    metrics: {'weight': weight, 'reps': reps},
  );

  RawSet cardio({required DateTime date}) => RawSet(
    sessionId: 2,
    exerciseName: 'Run',
    modality: Modality.cardio,
    sessionDate: date,
    metrics: {'distanceKm': 5, 'timeMin': 30},
  );

  group('ComputeWeeklyVolume', () {
    test('returns empty list for empty input', () {
      expect(usecase([]), isEmpty);
    });

    test('ignores non-strength sets', () {
      expect(usecase([cardio(date: june1)]), isEmpty);
    });

    test('sums weight × reps per week', () {
      final sets = [
        strength(date: june1, weight: 100, reps: 5), // 500
        // Wed Jun 3 — same week as Mon Jun 1
        strength(
          date: june1.add(const Duration(days: 2)),
          weight: 80,
          reps: 8,
        ), // 640
      ];
      final result = usecase(sets);
      expect(result, hasLength(1));
      expect(result.first.totalKg, closeTo(1140, 0.01));
      expect(result.first.setCount, 2);
    });

    test('groups into separate weeks', () {
      final sets = [
        strength(date: june1, weight: 100, reps: 5),
        strength(date: june8, weight: 100, reps: 5),
      ];
      final result = usecase(sets);
      expect(result, hasLength(2));
      expect(result.first.weekStart, june1);
      expect(result.last.weekStart, june8);
    });

    test('returns weeks sorted oldest first', () {
      final sets = [
        strength(date: june8, weight: 100, reps: 5),
        strength(date: june1, weight: 100, reps: 5),
      ];
      final result = usecase(sets);
      expect(result.first.weekStart, june1);
    });

    test('skips sets with zero weight or reps', () {
      final sets = [
        strength(date: june1, weight: 0, reps: 5),
        strength(date: june1, weight: 100, reps: 0),
      ];
      expect(usecase(sets), isEmpty);
    });
  });
}
