import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/entities/volume_point.dart';

/// Aggregates strength volume (weight × reps) per ISO week.
///
/// Only counts done strength sets. Returns weeks sorted oldest-first.
class ComputeWeeklyVolume {
  const ComputeWeeklyVolume();

  List<VolumePoint> call(List<RawSet> sets) {
    final byWeek = <DateTime, ({double total, int count})>{};

    for (final set in sets) {
      if (set.modality != Modality.strength) continue;
      final weight = set.metrics['weight'] ?? 0;
      final reps = set.metrics['reps'] ?? 0;
      if (weight <= 0 || reps <= 0) continue;

      final weekStart = _monday(set.sessionDate);
      final cur = byWeek[weekStart] ?? (total: 0, count: 0);
      byWeek[weekStart] = (
        total: cur.total + weight * reps,
        count: cur.count + 1,
      );
    }

    return byWeek.entries
        .map(
          (e) => VolumePoint(
            weekStart: e.key,
            totalKg: e.value.total,
            setCount: e.value.count,
          ),
        )
        .toList()
      ..sort((a, b) => a.weekStart.compareTo(b.weekStart));
  }

  DateTime _monday(DateTime dt) {
    final d = DateTime(dt.year, dt.month, dt.day);
    return d.subtract(Duration(days: d.weekday - 1));
  }
}
