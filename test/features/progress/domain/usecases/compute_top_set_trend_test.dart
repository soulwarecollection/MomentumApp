import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/usecases/compute_top_set_trend.dart';

void main() {
  const usecase = ComputeTopSetTrend();
  final day1 = DateTime(2026, 6);
  final day2 = DateTime(2026, 6, 3);

  RawSet strength({
    required DateTime date,
    required double weight,
    required double reps,
    int sessionId = 1,
  }) => RawSet(
    sessionId: sessionId,
    exerciseName: 'Deadlift',
    modality: Modality.strength,
    sessionDate: date,
    metrics: {'weight': weight, 'reps': reps},
  );

  group('ComputeTopSetTrend', () {
    test('returns empty list for empty input', () {
      expect(usecase([]), isEmpty);
    });

    test('ignores non-strength sets', () {
      final set = RawSet(
        sessionId: 1,
        exerciseName: 'Run',
        modality: Modality.cardio,
        sessionDate: day1,
        metrics: {'distanceKm': 5, 'timeMin': 30},
      );
      expect(usecase([set]), isEmpty);
    });

    test('returns one point per day with heaviest weight', () {
      final sets = [
        strength(date: day1, weight: 120, reps: 3),
        strength(date: day1, weight: 140, reps: 1), // heaviest
        strength(date: day1, weight: 100, reps: 5),
      ];
      final result = usecase(sets);
      expect(result, hasLength(1));
      expect(result.first.weight, 140);
      expect(result.first.reps, 1);
    });

    test('returns points sorted ascending by date', () {
      final sets = [
        strength(date: day2, weight: 130, reps: 3),
        strength(date: day1, weight: 120, reps: 3),
      ];
      final result = usecase(sets);
      expect(result, hasLength(2));
      expect(result.first.date, day1);
      expect(result.last.date, day2);
    });

    test('skips sets with zero weight', () {
      expect(usecase([strength(date: day1, weight: 0, reps: 5)]), isEmpty);
    });
  });
}
