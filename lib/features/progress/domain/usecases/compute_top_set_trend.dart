import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/entities/top_set_point.dart';

/// Best (heaviest) strength set per calendar day for a single exercise.
///
/// Expects sets already filtered to one exercise name.
class ComputeTopSetTrend {
  const ComputeTopSetTrend();

  List<TopSetPoint> call(List<RawSet> sets) {
    final topByDay = <DateTime, TopSetPoint>{};

    for (final set in sets) {
      if (set.modality != Modality.strength) continue;
      final weight = set.metrics['weight'] ?? 0;
      final reps = set.metrics['reps'] ?? 0;
      if (weight <= 0) continue;

      final day = DateTime(
        set.sessionDate.year,
        set.sessionDate.month,
        set.sessionDate.day,
      );
      final existing = topByDay[day];
      if (existing == null || weight > existing.weight) {
        topByDay[day] = TopSetPoint(
          date: day,
          weight: weight,
          reps: reps.round(),
        );
      }
    }

    return topByDay.values.toList()..sort((a, b) => a.date.compareTo(b.date));
  }
}
