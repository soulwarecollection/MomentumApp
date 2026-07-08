import 'package:momentum/core/enums/modality.dart';

class SessionSummary {
  const SessionSummary({
    required this.id,
    required this.startedAt,
    required this.setCount,
    required this.totalVolumeKg,
    this.focus,
    this.durationSeconds,
    this.dominantModality,
  });

  final int id;
  final String? focus;
  final DateTime startedAt;
  final int? durationSeconds;
  final int setCount;
  final double totalVolumeKg;
  final Modality? dominantModality;
}
