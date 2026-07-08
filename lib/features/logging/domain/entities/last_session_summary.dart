class LastSessionSummary {
  const LastSessionSummary({
    required this.setCount,
    this.maxWeightKg,
    this.setMetrics = const [],
  });

  final int setCount;
  final double? maxWeightKg;

  /// Per-set metrics from the last completed session, in set order —
  /// used to pre-fill this session's set rows (Smart Defaults).
  final List<Map<String, double>> setMetrics;
}
