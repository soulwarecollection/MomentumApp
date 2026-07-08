class OrmDataPoint {
  const OrmDataPoint({required this.date, required this.value});

  final DateTime date;

  /// Estimated 1RM in the same unit as the logged weight (kg or lb).
  final double value;
}
