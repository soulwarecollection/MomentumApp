import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/usecases/compute_volume_distribution.dart';

void main() {
  const usecase = ComputeVolumeDistribution();
  final day = DateTime(2026, 6);

  RawSet set(Modality m) => RawSet(
    sessionId: 1,
    exerciseName: 'Exercise',
    modality: m,
    sessionDate: day,
    metrics: {},
  );

  group('ComputeVolumeDistribution', () {
    test('returns empty map for empty input', () {
      expect(usecase([]), isEmpty);
    });

    test('single modality gives 100% share', () {
      final result = usecase([set(Modality.strength), set(Modality.strength)]);
      expect(result, hasLength(1));
      expect(result[Modality.strength], closeTo(1.0, 0.001));
    });

    test('splits correctly across modalities', () {
      final sets = [
        set(Modality.strength),
        set(Modality.strength),
        set(Modality.cardio),
      ];
      final result = usecase(sets);
      expect(result[Modality.strength], closeTo(2 / 3, 0.001));
      expect(result[Modality.cardio], closeTo(1 / 3, 0.001));
    });

    test('fractions sum to approximately 1.0', () {
      final sets = [
        set(Modality.strength),
        set(Modality.bodyweight),
        set(Modality.cardio),
        set(Modality.timed),
      ];
      final result = usecase(sets);
      final total = result.values.fold<double>(0, (a, b) => a + b);
      expect(total, closeTo(1.0, 0.001));
    });
  });
}
