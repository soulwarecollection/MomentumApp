class HeatmapCell {
  const HeatmapCell({required this.date, required this.count});

  final DateTime date;

  /// Number of sessions on this day (0 = none).
  final int count;
}
