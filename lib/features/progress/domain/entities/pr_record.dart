enum PrType { heaviestSet, bestSessionVolume }

class PrRecord {
  const PrRecord({
    required this.type,
    required this.exerciseName,
    required this.value,
    required this.unit,
    required this.achievedAt,
    this.reps,
    this.previous,
  });

  final PrType type;
  final String exerciseName;
  final double value;
  final String unit;
  final DateTime achievedAt;
  final int? reps;
  final double? previous;
}
