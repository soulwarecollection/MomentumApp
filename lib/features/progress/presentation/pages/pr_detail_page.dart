import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/progress/domain/entities/orm_data_point.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';
import 'package:momentum/features/progress/domain/usecases/compute_orm_trend.dart';
import 'package:momentum/features/progress/domain/usecases/compute_weekly_volume.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Route params:
///   [id]           — "heaviest" or "volume"
///   [exerciseName] — passed via route extra (String?) for "heaviest" PRs
class PrDetailPage extends StatefulWidget {
  const PrDetailPage({
    required this.id,
    this.exerciseName,
    super.key,
  });

  final String id;
  final String? exerciseName;

  @override
  State<PrDetailPage> createState() => _PrDetailPageState();
}

class _PrDetailPageState extends State<PrDetailPage> {
  static const _ormTrend = ComputeOrmTrend();
  static const _weeklyVolume = ComputeWeeklyVolume();

  bool _loading = true;
  String? _error;

  String _prValue = '';
  String _prUnit = '';
  String _prSub = '';
  String _prevBest = '';
  double _delta = 0;
  String _chartTitle = '';
  List<OrmDataPoint> _chartPoints = [];
  List<({String date, String value, bool isPr})> _history = [];

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final repo = GetIt.I<ProgressRepository>();

    if (widget.id == 'heaviest') {
      await _loadHeaviest(repo);
    } else {
      await _loadVolume(repo);
    }
  }

  Future<void> _loadHeaviest(ProgressRepository repo) async {
    final name = widget.exerciseName ?? '';
    if (name.isEmpty) {
      _setError('No exercise specified.');
      return;
    }
    final result = await repo.getDoneSetsForExercise(name).run();
    if (!mounted) return;
    result.fold(
      (f) => _setError(f.message),
      (sets) {
        final strength = sets
            .where((s) => s.modality == Modality.strength)
            .toList();
        if (strength.isEmpty) {
          _setError('No strength sets found.');
          return;
        }

        // Sort by weight desc to find PR and previous
        final sorted = [...strength]
          ..sort(
            (a, b) =>
                (b.metrics['weight'] ?? 0).compareTo(a.metrics['weight'] ?? 0),
          );

        final pr = sorted.first;
        final prW = pr.metrics['weight'] ?? 0;
        final prR = (pr.metrics['reps'] ?? 0).round();
        final prev = sorted.length > 1
            ? sorted[1].metrics['weight'] ?? 0
            : prW * 0.95;

        final ormPoints = _ormTrend(strength);
        final history = ormPoints.reversed
            .take(6)
            .map(
              (p) => (
                date: DateFormat('MMM d').format(p.date),
                value: '${p.value.toStringAsFixed(1)} kg (e1RM)',
                isPr: p == ormPoints.last,
              ),
            )
            .toList();

        setState(() {
          _prValue = prW.toStringAsFixed(
            prW.truncateToDouble() == prW ? 0 : 1,
          );
          _prUnit = 'kg';
          _prSub = '$name · $prR reps';
          _prevBest =
              '${prev.toStringAsFixed(prev.truncateToDouble() == prev ? 0 : 1)}'
              ' kg × $prR';
          _delta = prW - prev;
          _chartTitle = 'How this record climbed';
          _chartPoints = ormPoints;
          _history = history;
          _loading = false;
        });
      },
    );
  }

  Future<void> _loadVolume(ProgressRepository repo) async {
    final result = await repo.watchAllDoneSets().first;
    if (!mounted) return;
    result.fold(
      (f) => _setError(f.message),
      (sets) {
        final weekPoints = _weeklyVolume(sets);
        if (weekPoints.isEmpty) {
          _setError('No sessions found.');
          return;
        }

        final sorted = [...weekPoints]
          ..sort((a, b) => b.totalKg.compareTo(a.totalKg));
        final pr = sorted.first;
        final prev = sorted.length > 1 ? sorted[1].totalKg : pr.totalKg * 0.9;

        final ormPoints = weekPoints
            .map(
              (p) => OrmDataPoint(
                date: p.weekStart,
                value: p.totalKg,
              ),
            )
            .toList();

        final history = sorted
            .take(6)
            .map(
              (p) => (
                date: DateFormat('MMM d').format(p.weekStart),
                value: p.totalKg >= 1000
                    ? '${(p.totalKg / 1000).toStringAsFixed(1)}k kg'
                    : '${p.totalKg.toStringAsFixed(0)} kg',
                isPr: p == sorted.first,
              ),
            )
            .toList();

        final prVolStr = pr.totalKg >= 1000
            ? '${(pr.totalKg / 1000).toStringAsFixed(1)}k'
            : pr.totalKg.toStringAsFixed(0);
        final prevStr = prev >= 1000
            ? '${(prev / 1000).toStringAsFixed(1)}k kg'
            : '${prev.toStringAsFixed(0)} kg';

        setState(() {
          _prValue = prVolStr;
          _prUnit = 'kg';
          _prSub = 'Best session volume';
          _prevBest = prevStr;
          _delta = pr.totalKg - prev;
          _chartTitle = 'Weekly volume progression';
          _chartPoints = ormPoints;
          _history = history;
          _loading = false;
        });
      },
    );
  }

  void _setError(String msg) {
    if (!mounted) return;
    setState(() {
      _error = msg;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('PR')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('PR')),
        body: Center(child: Text(_error!)),
      );
    }

    final deltaStr = _delta >= 0
        ? '+${_delta.toStringAsFixed(1)}'
        : _delta.toStringAsFixed(1);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: const Icon(PhosphorIconsRegular.arrowLeft),
              onPressed: () => context.pop(),
            ),
            title: const Text('Progress'),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),

                // ── PR badge ───────────────────────────────────
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: tokens.accentSoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          PhosphorIconsFill.trophy,
                          size: 14,
                          color: tokens.accent,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'PERSONAL RECORD',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: tokens.accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: _prValue,
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ' $_prUnit',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: tokens.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    _prSub,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: tokens.muted,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // ── Previous best ──────────────────────────────
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(tokens.radiusCard),
                    boxShadow: tokens.cardShadow,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Previous best',
                              style: theme.textTheme.titleSmall,
                            ),
                            Text(
                              _prevBest,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: tokens.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        deltaStr,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: tokens.good,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── Chart ──────────────────────────────────────
                if (_chartPoints.isNotEmpty)
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
                          _chartTitle,
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 120,
                          child: _PrChart(points: _chartPoints),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),

                // ── History ────────────────────────────────────
                Text(
                  'Record history',
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
                    children: _history
                        .asMap()
                        .entries
                        .map(
                          (e) => _HistoryRow(
                            dateStr: e.value.date,
                            valueStr: e.value.value,
                            isPr: e.value.isPr,
                            isLast: e.key == _history.length - 1,
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

// ── PR area chart ─────────────────────────────────────────────────

class _PrChart extends StatelessWidget {
  const _PrChart({required this.points});

  final List<OrmDataPoint> points;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final origin = points.first.date.millisecondsSinceEpoch.toDouble();
    final spots = points.map((p) {
      final x = (p.date.millisecondsSinceEpoch - origin) / 86400000;
      return FlSpot(x, p.value);
    }).toList();

    final minY = points.map((p) => p.value).reduce((a, b) => a < b ? a : b);
    final maxY = points.map((p) => p.value).reduce((a, b) => a > b ? a : b);
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
  const _HistoryRow({
    required this.dateStr,
    required this.valueStr,
    required this.isPr,
    required this.isLast,
  });

  final String dateStr;
  final String valueStr;
  final bool isPr;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Text(
                dateStr,
                style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
              ),
              const Spacer(),
              Text(
                isPr ? '$valueStr · PR' : valueStr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isPr ? tokens.accent : null,
                  fontWeight: FontWeight.w600,
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
