import 'package:flutter/material.dart';
import 'package:momentum/core/theme/brand_tokens.dart';

/// Displays a single metric: a large Space-Grotesk number with an optional
/// unit badge and a small uppercase label below.
///
/// Matches the `.card .stat` and `.ring-num` styles from the prototype.
class StatTile extends StatelessWidget {
  const StatTile({
    required this.value,
    required this.label,
    super.key,
    this.unit,
  });

  final String value;
  final String? unit;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            if (unit != null) ...[
              const SizedBox(width: 2),
              Text(
                unit!.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: tokens.faint,
                  letterSpacing: 0.66, // ~0.06em at 11px
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 3),
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: tokens.muted,
            letterSpacing: 1, // ~0.1em at 10px
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
