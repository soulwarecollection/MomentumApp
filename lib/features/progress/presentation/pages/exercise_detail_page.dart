import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/entities/top_set_point.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';
import 'package:momentum/features/progress/domain/usecases/compute_orm_trend.dart';
import 'package:momentum/features/progress/domain/usecases/compute_top_set_trend.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ExerciseDetailPage extends StatefulWidget {
  const ExerciseDetailPage({required this.id, super.key});

  /// Exercise name (URL-decoded).
  final String id;

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  static const _ormTrend = ComputeOrmTrend();
  static const _topSetTrend = ComputeTopSetTrend();

  bool _loading = true;
  String? _error;
  List<RawSet> _sets = [];
  double _estimated1rm = 0;
  List<TopSetPoint> _topSets = [];

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final repo = GetIt.I<ProgressRepository>();
    final result = await repo.getDoneSetsForExercise(widget.id).run();
    if (!mounted) return;
    result.fold(
      (failure) => setState(() {
        _error = failure.message;
        _loading = false;
      }),
      (sets) {
        final ormPoints = _ormTrend(sets);
        setState(() {
          _sets = sets;
          _estimated1rm = ormPoints.isEmpty ? 0 : ormPoints.last.value;
          _topSets = _topSetTrend(sets);
          _loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.id)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.id)),
        body: Center(child: Text(_error!)),
      );
    }

    // Recent history (last 4 sessions with this exercise)
    final seenSessions = <int>{};
    final recentSets = _sets
        .where((s) {
          if (seenSessions.contains(s.sessionId)) return false;
          seenSessions.add(s.sessionId);
          return true;
        })
        .take(4)
        .toList();

    // Heaviest set
    double heaviestWeight = 0;
    var heaviestReps = 0;
    for (final s in _sets) {
      final w = s.metrics['weight'] ?? 0;
      if (w > heaviestWeight) {
        heaviestWeight = w;
        heaviestReps = (s.metrics['reps'] ?? 0).round();
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: const Icon(PhosphorIconsRegular.arrowLeft),
              onPressed: () => context.pop(),
            ),
            title: Text(widget.id),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),

                // ── Stat boxes ──────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _StatBox(
                        label: 'Estimated 1RM',
                        value: _estimated1rm > 0
                            ? _estimated1rm.toStringAsFixed(1)
                            : '—',
                        unit: _estimated1rm > 0 ? 'kg' : '',
                        delta: '▲ trending up',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatBox(
                        label: 'Heaviest set',
                        value: heaviestWeight > 0
                            ? heaviestWeight.toStringAsFixed(
                                heaviestWeight.truncateToDouble() ==
                                        heaviestWeight
                                    ? 0
                                    : 1,
                              )
                            : '—',
                        unit: heaviestWeight > 0 ? 'kg' : '',
                        delta: heaviestReps > 0 ? '$heaviestReps reps' : '',
                        deltaIcon: heaviestReps > 0
                            ? PhosphorIconsFill.trophy
                            : null,
                        deltaColor: tokens.accent,
                        deltaBackground: tokens.accentSoft,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Top set trend chart ──────────────────────────
                if (_topSets.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(tokens.radiusCard),
                      boxShadow: tokens.cardShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top set, last 6 weeks',
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 120,
                          child: _TopSetChart(points: _topSets),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // ── Recent history ───────────────────────────────
                Text(
                  'Recent history',
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(tokens.radiusCard),
                    boxShadow: tokens.cardShadow,
                  ),
                  child: Column(
                    children: recentSets.isEmpty
                        ? [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'No history.',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: tokens.muted,
                                ),
                              ),
                            ),
                          ]
                        : recentSets
                              .map(
                                (s) => _HistoryRow(
                                  set: s,
                                  isLast: s == recentSets.last,
                                ),
                              )
                              .toList(),
                  ),
                ),

                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
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
    required this.delta,
    this.deltaColor,
    this.deltaBackground,
    this.deltaIcon,
  });

  final String label;
  final String value;
  final String unit;
  final String delta;
  final Color? deltaColor;
  final Color? deltaBackground;
  final IconData? deltaIcon;

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
          if (delta.isNotEmpty) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: deltaBackground ?? tokens.goodSoft,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (deltaIcon != null) ...[
                    Icon(
                      deltaIcon,
                      size: 11,
                      color: deltaColor ?? tokens.good,
                    ),
                    const SizedBox(width: 3),
                  ],
                  Text(
                    delta,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: deltaColor ?? tokens.good,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Top set area chart ────────────────────────────────────────────

class _TopSetChart extends StatelessWidget {
  const _TopSetChart({required this.points});

  final List<TopSetPoint> points;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final origin = points.first.date.millisecondsSinceEpoch.toDouble();
    final spots = points.map((p) {
      final x = (p.date.millisecondsSinceEpoch - origin) / 86400000;
      return FlSpot(x, p.weight);
    }).toList();

    final minY = points.map((p) => p.weight).reduce((a, b) => a < b ? a : b);
    final maxY = points.map((p) => p.weight).reduce((a, b) => a > b ? a : b);
    final range = maxY - minY;

    return LineChart(
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
    );
  }
}

// ── History row ───────────────────────────────────────────────────

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.set, required this.isLast});

  final RawSet set;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    final dayStr = DateFormat('EEE').format(set.sessionDate);
    final w = set.metrics['weight'];
    final r = set.metrics['reps'];
    final setStr = (w != null && r != null)
        ? '${w.toStringAsFixed(w.truncateToDouble() == w ? 0 : 1)}'
              ' kg · ${r.toInt()} reps'
        : '';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Text(
                dayStr,
                style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
              ),
              const Spacer(),
              Text(
                setStr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: tokens.line,
          ),
      ],
    );
  }
}
