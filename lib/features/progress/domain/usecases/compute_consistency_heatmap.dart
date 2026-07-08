import 'package:momentum/features/progress/domain/entities/heatmap_cell.dart';

/// Builds a 12-week × 7-day heatmap (84 cells) from a list of session dates.
///
/// Cells are indexed [week * 7 + dayOfWeek] where week 0 is the oldest
/// (12 weeks ago) and dayOfWeek 0 is Monday.
class ComputeConsistencyHeatmap {
  const ComputeConsistencyHeatmap();

  static const int weeks = 12;
  static const int totalCells = weeks * 7;

  List<HeatmapCell> call(List<DateTime> sessionDates, {DateTime? today}) {
    final now = today ?? DateTime.now();
    final todayDay = DateTime(now.year, now.month, now.day);

    // Monday of this week
    final thisMonday = todayDay.subtract(Duration(days: todayDay.weekday - 1));
    // Monday 12 weeks ago (oldest column)
    final startMonday = thisMonday.subtract(
      const Duration(days: (weeks - 1) * 7),
    );

    // Count sessions per calendar day
    final counts = <DateTime, int>{};
    for (final d in sessionDates) {
      final key = DateTime(d.year, d.month, d.day);
      counts[key] = (counts[key] ?? 0) + 1;
    }

    return List.generate(totalCells, (i) {
      final date = startMonday.add(Duration(days: i));
      return HeatmapCell(date: date, count: counts[date] ?? 0);
    });
  }
}
