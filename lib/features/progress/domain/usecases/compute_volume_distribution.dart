import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';

/// Returns each modality's share of done sets as a fraction (0–1).
///
/// Useful for a volume distribution chart. Returns an empty map
/// when the input is empty.
class ComputeVolumeDistribution {
  const ComputeVolumeDistribution();

  Map<Modality, double> call(List<RawSet> sets) {
    if (sets.isEmpty) return {};

    final counts = <Modality, int>{};
    for (final set in sets) {
      counts[set.modality] = (counts[set.modality] ?? 0) + 1;
    }

    final total = counts.values.fold(0, (a, b) => a + b);
    return counts.map((k, v) => MapEntry(k, v / total));
  }
}
