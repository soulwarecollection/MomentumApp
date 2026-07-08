import 'package:flutter/material.dart';
import 'package:momentum/core/theme/brand_tokens.dart';

/// Surface card matching the prototype's `.card` / `.today-card` style:
/// 1dp border, radiusCard (16), prototype card-shadow, surface background.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
    this.padding,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final decorated = DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: tokens.line),
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        boxShadow: tokens.cardShadow,
      ),
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: child,
      ),
    );

    if (onTap == null) return decorated;

    return ClipRRect(
      borderRadius: BorderRadius.circular(tokens.radiusCard),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: decorated,
        ),
      ),
    );
  }
}
