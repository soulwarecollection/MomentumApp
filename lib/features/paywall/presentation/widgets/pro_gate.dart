import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/paywall/domain/pro_access_policy.dart';
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Future<bool> requirePro(
  BuildContext context, {
  required ProFeature feature,
}) async {
  if (context.read<EntitlementCubit>().state.isPro) return true;
  final unlocked = await context.push<bool>('/paywall', extra: feature);
  if (!context.mounted) return false;
  return unlocked == true || context.read<EntitlementCubit>().state.isPro;
}

class ProGate extends StatelessWidget {
  const ProGate({
    required this.feature,
    required this.child,
    this.lockedChild,
    this.blurLocked = false,
    super.key,
  });

  final ProFeature feature;
  final Widget child;
  final Widget? lockedChild;

  /// When true (and not Pro), shows the real [child] blurred and
  /// desaturated behind the unlock CTA instead of hiding it — seeing your
  /// own real data behind frosted glass is a stronger incentive than an
  /// abstract padlock. Only sensible when [child] doesn't depend on data
  /// the free tier hasn't already loaded.
  final bool blurLocked;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntitlementCubit, EntitlementState>(
      buildWhen: (previous, current) => previous.isPro != current.isPro,
      builder: (context, state) {
        if (state.isPro) return child;
        if (blurLocked) {
          return _BlurredProGate(feature: feature, child: child);
        }
        return lockedChild ?? ProLockedCard(feature: feature);
      },
    );
  }
}

const _greyscale = ColorFilter.matrix(<double>[
  0.2126, 0.7152, 0.0722, 0, 0, //
  0.2126, 0.7152, 0.0722, 0, 0, //
  0.2126, 0.7152, 0.0722, 0, 0, //
  0, 0, 0, 1, 0, //
]);

class _BlurredProGate extends StatelessWidget {
  const _BlurredProGate({required this.feature, required this.child});

  final ProFeature feature;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    return ClipRRect(
      borderRadius: BorderRadius.circular(tokens.radiusCard),
      child: Stack(
        alignment: Alignment.center,
        children: [
          IgnorePointer(
            child: ColorFiltered(
              colorFilter: _greyscale,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: child,
              ),
            ),
          ),
          Positioned.fill(
            child: ColoredBox(
              color: theme.colorScheme.surface.withValues(alpha: 0.35),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIconsRegular.lockSimple,
                  color: tokens.accent,
                  size: 25,
                ),
                const SizedBox(height: 8),
                Text(
                  feature.title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature.description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.muted,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: tokens.accent,
                    foregroundColor: const Color(0xFF241C00),
                  ),
                  onPressed: () => unawaited(
                    requirePro(context, feature: feature),
                  ),
                  child: const Text('Unlock with Pro'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProLockedCard extends StatelessWidget {
  const ProLockedCard({required this.feature, super.key});

  final ProFeature feature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: tokens.line),
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        children: [
          Icon(PhosphorIconsRegular.lockSimple, color: tokens.accent, size: 25),
          const SizedBox(height: 8),
          Text(
            feature.title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            feature.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: tokens.muted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: tokens.accent,
              foregroundColor: const Color(0xFF241C00),
            ),
            onPressed: () => unawaited(
              requirePro(context, feature: feature),
            ),
            child: const Text('Unlock with Pro'),
          ),
        ],
      ),
    );
  }
}
