import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/core/common/widgets/momentum_logo.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/paywall/domain/entities/pro_package.dart';
import 'package:momentum/features/paywall/domain/pro_access_policy.dart';
import 'package:momentum/features/paywall/presentation/cubits/paywall_cubit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({this.feature, super.key});

  final ProFeature? feature;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<PaywallCubit>();
        unawaited(cubit.load());
        return cubit;
      },
      child: _PaywallView(feature: feature),
    );
  }
}

class _PaywallView extends StatelessWidget {
  const _PaywallView({required this.feature});

  final ProFeature? feature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;

    return BlocListener<PaywallCubit, PaywallState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == PaywallStatus.success,
      listener: (context, state) => context.pop(true),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PaywallCubit, PaywallState>(
            builder: (context, state) {
              if (state.status == PaywallStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      tooltip: 'Close',
                      onPressed: () => context.pop(false),
                      icon: const Icon(PhosphorIconsRegular.x),
                    ),
                  ),
                  const Center(child: MomentumLogo(size: 48)),
                  const SizedBox(height: 10),
                  Text(
                    'Build momentum without limits',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.45,
                    ),
                  ),
                  const SizedBox(height: 5),
                  _Subtitle(feature: feature),
                  const SizedBox(height: 20),
                  const _FeatureRow(text: 'Unlimited training plans'),
                  const _FeatureRow(
                    text: 'Full analytics and long-range trends',
                  ),
                  const _FeatureRow(
                    text: 'Cloud sync, backup, and Watch logging',
                  ),
                  const _FeatureRow(
                    text: 'One subscription across your devices',
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: state.packages
                        .map(
                          (package) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: package.plan == ProPlan.lifetime ? 0 : 8,
                              ),
                              child: _PriceOption(
                                package: package,
                                selected: state.selectedPlan == package.plan,
                                onTap: () => context
                                    .read<PaywallCubit>()
                                    .selectPlan(package.plan),
                              ),
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                  if (state.message != null) ...[
                    const SizedBox(height: 14),
                    Text(
                      state.message!,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: state.status == PaywallStatus.error
                            ? theme.colorScheme.error
                            : tokens.muted,
                      ),
                    ),
                  ],
                  const SizedBox(height: 18),
                  FilledButton(
                    onPressed:
                        state.isBusy || !state.selectedPackage.isPurchasable
                        ? null
                        : () => unawaited(
                            context.read<PaywallCubit>().purchaseSelected(),
                          ),
                    child: state.status == PaywallStatus.purchasing
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('Continue with ${state.selectedPlan.label}'),
                  ),
                  TextButton(
                    onPressed: state.isBusy || !state.storeConfigured
                        ? null
                        : () => unawaited(
                            context.read<PaywallCubit>().restore(),
                          ),
                    child: Text(
                      state.status == PaywallStatus.restoring
                          ? 'Restoring…'
                          : 'Restore purchases',
                    ),
                  ),
                  Text(
                    'Subscriptions renew automatically unless cancelled. '
                    'Lifetime is a one-time purchase. Manage or cancel in '
                    'your store account.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: tokens.faint,
                      height: 1.45,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ── Subtitle (contextual for data-driven features) ──────────────────────────

/// Features where anchoring on the user's own logged history is a
/// stronger nudge than the generic feature description (Loss Aversion +
/// Endowment Effect: the sunk cost is *their* data, not an abstract pitch).
const Set<ProFeature> _contextualFeatures = {
  ProFeature.volumeBalance,
  ProFeature.advancedAnalytics,
};

class _Subtitle extends StatelessWidget {
  const _Subtitle({required this.feature});

  final ProFeature? feature;

  static const _fallback =
      'Your training data stays yours. Pro adds depth, '
      'backup, and flexibility.';

  String _contextualCopy(ProFeature feature, int sessionCount) {
    final sessions = sessionCount == 1 ? 'session' : 'sessions';
    return switch (feature) {
      ProFeature.volumeBalance =>
        "You've logged $sessionCount $sessions — see exactly where "
            'that volume goes with Pro.',
      ProFeature.advancedAnalytics =>
        "You've logged $sessionCount $sessions of history — unlock "
            '6-month and all-time trends with Pro.',
      _ => feature.description,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final style = theme.textTheme.bodyMedium?.copyWith(
      color: tokens.muted,
      height: 1.45,
    );

    final currentFeature = feature;
    if (currentFeature == null ||
        !_contextualFeatures.contains(currentFeature)) {
      return Text(
        currentFeature?.description ?? _fallback,
        textAlign: TextAlign.center,
        style: style,
      );
    }

    return FutureBuilder<List<SessionRow>>(
      future: getIt<AppDatabase>().sessionsDao.watchActiveSessions().first,
      builder: (context, snapshot) {
        final count = snapshot.data?.length;
        return Text(
          count == null || count == 0
              ? currentFeature.description
              : _contextualCopy(currentFeature, count),
          textAlign: TextAlign.center,
          style: style,
        );
      },
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            PhosphorIconsRegular.check,
            size: 19,
            color: context.brandTokens.good,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceOption extends StatelessWidget {
  const _PriceOption({
    required this.package,
    required this.selected,
    required this.onTap,
  });

  final ProPackage package;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final badge = package.plan.badge;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 92),
        padding: const EdgeInsets.fromLTRB(6, 15, 6, 12),
        decoration: BoxDecoration(
          color: selected ? tokens.primarySoft : theme.colorScheme.surface,
          border: Border.all(
            color: selected ? theme.colorScheme.primary : tokens.line2,
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  package.plan.label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: tokens.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: package.price,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ' ${package.plan.periodLabel}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: tokens.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (package.perMonthEquivalent != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    "that's ${package.perMonthEquivalent}",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: tokens.good,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
            if (badge != null)
              Positioned(
                top: -24,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
