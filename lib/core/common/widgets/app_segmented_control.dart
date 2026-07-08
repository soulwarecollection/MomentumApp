import 'package:flutter/material.dart';

/// A labelled segmented control wrapping Material 3 [SegmentedButton].
///
/// Used for range pickers (1M / 3M / 6M / 1Y) and similar toggles.
class AppSegmentedControl extends StatelessWidget {
  const AppSegmentedControl({
    required this.segments,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<int>(
      showSelectedIcon: false,
      segments: List.generate(
        segments.length,
        (i) => ButtonSegment<int>(value: i, label: Text(segments[i])),
      ),
      selected: {selectedIndex},
      onSelectionChanged: (set) => onSelected(set.first),
    );
  }
}
