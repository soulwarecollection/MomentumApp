import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum/core/common/widgets/error_state.dart';
import 'package:momentum/core/common/widgets/skeleton_box.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/goals/domain/entities/goal_progress.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_cubit.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_state.dart';
import 'package:momentum/features/paywall/domain/pro_access_policy.dart';
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart';
import 'package:momentum/features/paywall/presentation/widgets/pro_gate.dart';
import 'package:momentum/features/progress/domain/entities/orm_data_point.dart';
import 'package:momentum/features/progress/domain/entities/pr_record.dart';
import 'package:momentum/features/progress/domain/enums/date_range.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';
import 'package:momentum/features/progress/presentation/cubits/progress_cubit.dart';
import 'package:momentum/features/progress/presentation/cubits/progress_state.dart';
import 'package:momentum/features/weight/presentation/widgets/weight_chart.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final c = ProgressCubit(GetIt.I<ProgressRepository>());
        unawaited(c.load());
        return c;
      },
      child: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressCubit, ProgressState>(
      builder: (context, state) => switch (state) {
        ProgressLoading() => const Scaffold(
          body: SkeletonList(),
        ),
        ProgressEmpty() => const _EmptyState(),
        ProgressReady() => _ReadyBody(state: state),
        ProgressError(:final message) => Scaffold(
          body: ErrorStateWidget(message: message),
        ),
      },
    );
  }
}

// ── Empty ──────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.chartBar,
              size: 48,
              color: Theme.of(context).extension<BrandTokens>()?.muted,
            ),
            const SizedBox(height: 16),
            Text(
              'No workouts yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Log a session to start tracking progress.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).extension<BrandTokens>()?.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Ready body ────────────────────────────────────────────────────

class _ReadyBody extends StatelessWidget {
  const _ReadyBody({required this.state});

  final ProgressReady state;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);
    final isPro = context.watch<EntitlementCubit>().state.isPro;
    final trendLabel = state.filteredTrendPoints.isEmpty
        ? 'no data'
        : 'trending up';
    final weekVolumeLabel = state.weekVolumeKg >= 1000
        ? '${(state.weekVolumeKg / 1000).toStringAsFixed(1)}k'
        : state.weekVolumeKg.toStringAsFixed(0);

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PROGRESS',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: tokens.faint,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.4,
                      ),
                    ),
                    Text(
                      state.focusExercise,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.55,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Last ${state.selectedRange.label} · $trendLabel',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: tokens.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<GoalCubit, GoalState>(
                builder: (context, goalState) {
                  if (goalState is! GoalActive) return const SizedBox.shrink();
                  final suggestion = goalState.progress.suggestion;
                  if (suggestion == null) return const SizedBox.shrink();
                  return _GoalSuggestionBanner(
                    suggestion: suggestion,
                    progress: goalState.progress,
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),

                  // ── Stat boxes ──────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: _StatBox(
                          label: 'Estimated 1RM',
                          value: state.estimated1rm > 0
                              ? state.estimated1rm.toStringAsFixed(1)
                              : '—',
                          unit: state.estimated1rm > 0 ? 'kg' : '',
                          sparkValues: state.ormSparkValues,
                          color: tokens.good,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatBox(
                          label: 'Volume this week',
                          value: weekVolumeLabel,
                          unit: 'kg',
                          sparkValues: state.volumeSparkValues,
                          color: tokens.good,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Range toggle ─────────────────────────────────
                  _RangeToggle(selected: state.selectedRange),
                  const SizedBox(height: 16),

                  // ── Trend chart ──────────────────────────────────
                  _TrendChart(
                    points: state.filteredTrendPoints,
                    exercise: state.focusExercise,
                  ),
                  const SizedBox(height: 24),

                  // ── Volume distribution (PRO) ────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Where your volume goes',
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      if (!isPro)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: tokens.accentSoft,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'PRO',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: tokens.accent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      Text(
                        'This week',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.muted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ProGate(
                    feature: ProFeature.volumeBalance,
                    blurLocked: true,
                    child: _VolumeDistribution(
                      distribution: state.volumeDistribution,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── PR cards ─────────────────────────────────────
                  Text(
                    'Personal records',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  ...state.prRecords.map(
                    (pr) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _PrCard(pr: pr),
                    ),
                  ),

                  // ── Body weight ──────────────────────────────────
                  const SizedBox(height: 24),
                  const WeightSection(),

                  // ── History link ─────────────────────────────────
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () =>
                        unawaited(context.push('/progress/history')),
                    icon: const Icon(
                      PhosphorIconsRegular.clockCounterClockwise,
                    ),
                    label: const Text('View full history'),
                  ),
                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat box ──────────────────────────────────────────────────────

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.label,
    required this.value,
    required this.unit,
    required this.sparkValues,
    required this.color,
  });

  final String label;
  final String value;
  final String unit;
  final List<double> sparkValues;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sparkValues.isNotEmpty)
            SizedBox(
              width: 52,
              height: 24,
              child: _Sparkline(values: sparkValues, color: color),
            ),
          if (sparkValues.isNotEmpty) const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (unit.isNotEmpty)
                  TextSpan(
                    text: ' $unit',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: tokens.muted,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
          ),
        ],
      ),
    );
  }
}

// ── Sparkline ─────────────────────────────────────────────────────

class _Sparkline extends StatelessWidget {
  const _Sparkline({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return const SizedBox.shrink();

    final minY = values.reduce((a, b) => a < b ? a : b);
    final maxY = values.reduce((a, b) => a > b ? a : b);
    final range = maxY - minY;

    final spots = List.generate(
      values.length,
      (i) => FlSpot(i.toDouble(), values[i]),
    );

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: color,
            barWidth: 1.5,
            dotData: const FlDotData(show: false),
          ),
        ],
        minY: range > 0 ? minY - range * 0.1 : minY - 1,
        maxY: range > 0 ? maxY + range * 0.1 : maxY + 1,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(),
          rightTitles: AxisTitles(),
          topTitles: AxisTitles(),
          bottomTitles: AxisTitles(),
        ),
      ),
    );
  }
}

// ── Range toggle ──────────────────────────────────────────────────

class _RangeToggle extends StatelessWidget {
  const _RangeToggle({required this.selected});

  final DateRange selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<EntitlementCubit, EntitlementState>(
      buildWhen: (previous, current) => previous.isPro != current.isPro,
      builder: (context, entitlement) => Row(
        children: DateRange.values.map((r) {
          final isOn = r == selected;
          final locked = r.isPro && !entitlement.isPro;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => unawaited(
                _selectRange(context, r, entitlement.isPro),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isOn
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      r.label,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: isOn
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (locked) ...[
                      const SizedBox(width: 4),
                      Icon(
                        PhosphorIconsRegular.lockSimple,
                        size: 12,
                        color: isOn
                            ? theme.colorScheme.onPrimary.withValues(alpha: 0.7)
                            : theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _selectRange(
    BuildContext context,
    DateRange range,
    bool isPro,
  ) async {
    if (!ProAccessPolicy.canUseDateRange(isPro: isPro, range: range)) {
      final unlocked = await requirePro(
        context,
        feature: ProFeature.advancedAnalytics,
      );
      if (!unlocked || !context.mounted) return;
    }
    context.read<ProgressCubit>().setRange(range);
  }
}

// ── Trend chart (area) ────────────────────────────────────────────

class _TrendChart extends StatelessWidget {
  const _TrendChart({required this.points, required this.exercise});

  final List<OrmDataPoint> points;
  final String exercise;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    Widget chart;
    if (points.isEmpty) {
      chart = SizedBox(
        height: 140,
        child: Center(
          child: Text(
            'No data for this range',
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
          ),
        ),
      );
    } else {
      final minY = points.map((p) => p.value).reduce((a, b) => a < b ? a : b);
      final maxY = points.map((p) => p.value).reduce((a, b) => a > b ? a : b);
      final range = maxY - minY;
      final origin = points.first.date.millisecondsSinceEpoch.toDouble();

      final spots = points.map((p) {
        final x = (p.date.millisecondsSinceEpoch - origin) / 86400000;
        return FlSpot(x, p.value);
      }).toList();

      chart = SizedBox(
        height: 140,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: primary,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: primary.withValues(alpha: 0.15),
                ),
              ),
            ],
            minY: range > 0 ? minY - range * 0.15 : minY - 5,
            maxY: range > 0 ? maxY + range * 0.15 : maxY + 5,
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(),
              rightTitles: AxisTitles(),
              topTitles: AxisTitles(),
              bottomTitles: AxisTitles(),
            ),
          ),
        ),
      );
    }

    final bestKg = points.isEmpty
        ? null
        : points.map((p) => p.value).reduce((a, b) => a > b ? a : b);
    final trendGain = bestKg == null
        ? null
        : (bestKg - points.first.value).toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top set weight',
                      style: theme.textTheme.titleSmall,
                    ),
                    if (trendGain != null)
                      Text(
                        '+$trendGain kg since start',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.muted,
                        ),
                      ),
                  ],
                ),
              ),
              if (bestKg != null)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: bestKg.toStringAsFixed(1),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' kg · best set',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.muted,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          chart,
        ],
      ),
    );
  }
}

// ── Volume distribution ───────────────────────────────────────────

class _VolumeDistribution extends StatelessWidget {
  const _VolumeDistribution({required this.distribution});

  final Map<Modality, double> distribution;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    Color colorFor(Modality m) => switch (m) {
      Modality.strength => tokens.push,
      Modality.bodyweight => tokens.pull,
      Modality.cardio => tokens.cardio,
      Modality.timed => tokens.legs,
    };

    String labelFor(Modality m) => switch (m) {
      Modality.strength => 'Strength',
      Modality.bodyweight => 'Bodyweight',
      Modality.cardio => 'Cardio',
      Modality.timed => 'Timed',
    };

    if (distribution.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(tokens.radiusCard),
          boxShadow: tokens.cardShadow,
        ),
        child: Text(
          'No sessions this week.',
          style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Row(
              children: distribution.entries.map((e) {
                return Expanded(
                  flex: (e.value * 100).round(),
                  child: Container(
                    height: 12,
                    color: colorFor(e.key),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          // Legend
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: distribution.entries.map((e) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: colorFor(e.key),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${labelFor(e.key)} ${(e.value * 100).round()}%',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ── PR card ───────────────────────────────────────────────────────

class _PrCard extends StatelessWidget {
  const _PrCard({required this.pr});

  final PrRecord pr;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);
    final dateStr = DateFormat('MMM d').format(pr.achievedAt);
    final volumeValue = pr.value >= 1000
        ? '${(pr.value / 1000).toStringAsFixed(1)}k'
        : pr.value.toStringAsFixed(0);

    final label = switch (pr.type) {
      PrType.heaviestSet => 'Heaviest set',
      PrType.bestSessionVolume => 'Best session volume',
    };

    final meta = switch (pr.type) {
      PrType.heaviestSet =>
        '${pr.value.toStringAsFixed(1)} kg × ${pr.reps} · $dateStr',
      PrType.bestSessionVolume => '$volumeValue kg · $dateStr',
    };

    final routeId = switch (pr.type) {
      PrType.heaviestSet => 'heaviest',
      PrType.bestSessionVolume => 'volume',
    };

    return GestureDetector(
      onTap: () => unawaited(
        context.push(
          '/progress/pr/$routeId',
          extra: pr.exerciseName,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(tokens.radiusCard),
          boxShadow: tokens.cardShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 64,
              decoration: BoxDecoration(
                color: tokens.accent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    meta,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tokens.muted,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIconsRegular.caretRight,
              color: tokens.muted,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

// ── Goal suggestion banner ──────────────────────────────────────────────

class _GoalSuggestionBanner extends StatelessWidget {
  const _GoalSuggestionBanner({
    required this.suggestion,
    required this.progress,
  });

  final GoalSuggestion suggestion;
  final GoalProgress progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = Theme.of(context).extension<BrandTokens>()!;

    final (icon, text) = switch (suggestion) {
      GoalSuggestion.checkCalories => (
        PhosphorIconsRegular.scales,
        'Body weight has been flat for 5+ days against your fat-loss goal '
            '— consider reviewing your calorie intake.',
      ),
      GoalSuggestion.strengthBehind => (
        PhosphorIconsRegular.trendDown,
        "You're behind pace on your "
            '${progress.goal.exerciseName ?? "strength"} goal '
            '(${progress.gapValue.toStringAsFixed(1)} kg to go) '
            '— consider adding a heavier session.',
      ),
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(tokens.radiusCard),
          border: Border.all(
            color: theme.colorScheme.error.withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: theme.colorScheme.error),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
