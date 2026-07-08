import 'package:momentum/core/enums/modality.dart';

class SessionExerciseDetail {
  const SessionExerciseDetail({
    required this.name,
    required this.modality,
    required this.doneSets,
  });

  final String name;
  final Modality modality;

  /// Metrics maps for each completed set, in order.
  final List<Map<String, double>> doneSets;
}
