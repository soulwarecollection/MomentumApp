import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/usecases/compute_orm_trend.dart';

void main() {
  const usecase = ComputeOrmTrend();
  final day1 = DateTime(2026, 6);
  final day2 = DateTime(2026, 6, 3);

  RawSet strength({
    required DateTime date,
    required double weight,
    required double reps,
    int sessionId = 1,
  }) => RawSet(
    sessionId: sessionId,
    exerciseName: 'Bench Press',
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

  group('ComputeOrmTrend', () {
    test('returns empty list for empty input', () {
      expect(usecase([]), isEmpty);
    });

    test('ignores non-strength sets', () {
      expect(usecase([cardio(date: day1)]), isEmpty);
    });

    test('applies Epley formula correctly', () {
      final result = usecase([strength(date: day1, weight: 100, reps: 5)]);
      expect(result, hasLength(1));
      // Epley: 100 * (1 + 5/30) ≈ 116.67
      expect(result.first.value, closeTo(116.67, 0.01));
    });

    test('keeps max 1RM per day when multiple sets on same day', () {
      final sets = [
        strength(date: day1, weight: 100, reps: 5), // 1RM ≈ 116.67
        strength(date: day1, weight: 90, reps: 10), // 1RM = 120
      ];
      final result = usecase(sets);
      expect(result, hasLength(1));
      expect(result.first.value, closeTo(120, 0.01));
    });

    test('returns one point per day sorted ascending', () {
      final sets = [
        strength(date: day2, weight: 102, reps: 5),
        strength(date: day1, weight: 100, reps: 5),
      ];
      final result = usecase(sets);
      expect(result, hasLength(2));
      expect(result.first.date, day1);
      expect(result.last.date, day2);
    });

    test('skips sets with zero weight or reps', () {
      final sets = [
        strength(date: day1, weight: 0, reps: 5),
        strength(date: day1, weight: 100, reps: 0),
      ];
      expect(usecase(sets), isEmpty);
    });
  });
}
