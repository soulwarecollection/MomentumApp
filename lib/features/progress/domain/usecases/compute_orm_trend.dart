import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/progress/domain/entities/orm_data_point.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';

/// Epley 1RM estimate per day for a single exercise.
///
/// Groups done strength sets by calendar day and keeps the
/// highest estimated 1RM (weight × (1 + reps / 30)) per day.
class ComputeOrmTrend {
  const ComputeOrmTrend();

  List<OrmDataPoint> call(List<RawSet> sets) {
    final maxByDate = <DateTime, double>{};

    for (final set in sets) {
      if (set.modality != Modality.strength) continue;
      final weight = set.metrics['weight'] ?? 0;
      final reps = set.metrics['reps'] ?? 0;
      if (weight <= 0 || reps <= 0) continue;

      final orm = weight * (1 + reps / 30);
      final day = _day(set.sessionDate);
      if (!maxByDate.containsKey(day) || maxByDate[day]! < orm) {
        maxByDate[day] = orm;
      }
    }

    return maxByDate.entries
        .map((e) => OrmDataPoint(date: e.key, value: e.value))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  DateTime _day(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}
