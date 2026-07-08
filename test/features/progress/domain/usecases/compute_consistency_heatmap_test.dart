import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/features/progress/domain/usecases/compute_consistency_heatmap.dart';

void main() {
  const usecase = ComputeConsistencyHeatmap();

  // Friday 26 June 2026 (weekday=5).
  // thisMonday = Jun 22. startMonday = Jun 22 - 77 days = Apr 6.
  final today = DateTime(2026, 6, 26);
  // Apr 6, 2026 is a Monday (weekday=1) — first cell of the grid.
  final startMonday = DateTime(2026, 4, 6);

  group('ComputeConsistencyHeatmap', () {
    test('always produces exactly 84 cells', () {
      final result = usecase([], today: today);
      expect(result, hasLength(84));
    });

    test('all cells have count zero for empty input', () {
      final result = usecase([], today: today);
      expect(result.every((c) => c.count == 0), isTrue);
    });

    test('first cell is Monday of the window start', () {
      final result = usecase([], today: today);
      expect(result.first.date, startMonday);
    });

    test('last cell is startMonday + 83 days', () {
      final result = usecase([], today: today);
      expect(result.last.date, startMonday.add(const Duration(days: 83)));
    });

    test('increments count for matching session date', () {
      final result = usecase([startMonday], today: today);
      expect(result.first.count, 1);
    });

    test('counts multiple sessions on the same day', () {
      final result = usecase(
        [startMonday, startMonday, startMonday],
        today: today,
      );
      expect(result.first.count, 3);
    });

    test('ignores sessions one day before the window', () {
      final dayBefore = startMonday.subtract(const Duration(days: 1));
      final result = usecase([dayBefore], today: today);
      expect(result.every((c) => c.count == 0), isTrue);
    });
  });
}
