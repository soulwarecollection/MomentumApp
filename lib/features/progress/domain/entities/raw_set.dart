import 'package:momentum/core/enums/modality.dart';

class RawSet {
  const RawSet({
    required this.sessionId,
    required this.exerciseName,
    required this.modality,
    required this.sessionDate,
    required this.metrics,
  });

  final int sessionId;
  final String exerciseName;
  final Modality modality;
  final DateTime sessionDate;
  final Map<String, double> metrics;
}
