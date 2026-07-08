import 'package:flutter/material.dart';
import 'package:momentum/core/theme/brand_tokens.dart';

/// Full-width primary CTA button.
///
/// Matches the `.start-cta` style from the prototype:
/// radiusSmall (13), 52dp min-height, bold 15px Inter label.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final radius = context.brandTokens.radiusSmall;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
    const style = TextStyle(fontSize: 15, fontWeight: FontWeight.w700);
    final child = loading
        ? const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label);

    if (icon != null && !loading) {
      return FilledButton.icon(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          shape: shape,
          textStyle: style,
        ),
        icon: icon,
        label: Text(label),
      );
    }

    return FilledButton(
      onPressed: loading ? null : onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        shape: shape,
        textStyle: style,
      ),
      child: child,
    );
  }
}
