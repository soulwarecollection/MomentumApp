import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum/core/enums/equipment_type.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/library/domain/entities/exercise.dart';
import 'package:momentum/features/logging/domain/entities/exercise_entry.dart';
import 'package:momentum/features/logging/domain/entities/set_row.dart';
import 'package:momentum/features/logging/presentation/pages/logging_page.dart'
    show StartSessionArgs;
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/entities/top_set_point.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';
import 'package:momentum/features/progress/domain/usecases/compute_orm_trend.dart';
import 'package:momentum/features/progress/domain/usecases/compute_top_set_trend.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CatalogExerciseDetailPage extends StatefulWidget {
  const CatalogExerciseDetailPage({required this.exercise, super.key});

  final Exercise exercise;

  @override
  State<CatalogExerciseDetailPage> createState() =>
      _CatalogExerciseDetailPageState();
}

class _CatalogExerciseDetailPageState extends State<CatalogExerciseDetailPage> {
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
    final result = await repo
        .getDoneSetsForExercise(widget.exercise.name)
        .run();
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

  void _logThisExercise() {
    final localId = DateTime.now().microsecondsSinceEpoch.toString();
    context.go(
      '/log',
      extra: StartSessionArgs(
        focus: widget.exercise.name,
        exercises: [
          ExerciseEntry(
            localId: localId,
            name: widget.exercise.name,
            modality: widget.exercise.modality,
            equipment: EquipmentType.values
                .asNameMap()[widget.exercise.equipment],
            sets: [
              SetRow(
                localId: '${localId}_0',
                metrics: _defaultMetrics(widget.exercise.modality),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, double> _defaultMetrics(Modality m) => switch (m) {
    Modality.strength => {'weight': 0, 'reps': 0},
    Modality.bodyweight => {'reps': 0},
    Modality.cardio => {'distanceKm': 0, 'timeMin': 0},
    Modality.timed => {'timeMin': 0},
  };

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.exercise.name)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.exercise.name)),
        body: Center(child: Text(_error!)),
      );
    }

    final seenSessions = <int>{};
    final recentSets = _sets
        .where((s) {
          if (seenSessions.contains(s.sessionId)) return false;
          seenSessions.add(s.sessionId);
          return true;
        })
        .take(4)
        .toList();

    double heaviestWeight = 0;
    var heaviestReps = 0;
    for (final s in _sets) {
      final w = s.metrics['weight'] ?? 0;
      if (w > heaviestWeight) {
        heaviestWeight = w;
        heaviestReps = (s.metrics['reps'] ?? 0).round();
      }
    }

    final color = _modalityColor(tokens, widget.exercise.modality);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _logThisExercise,
        icon: const Icon(PhosphorIconsRegular.plus),
        label: const Text('Log this exercise'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: const Icon(PhosphorIconsRegular.arrowLeft),
              onPressed: context.pop,
            ),
            title: Text(widget.exercise.name),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Modality / metadata chip row ────────────────────
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      avatar: Icon(
                        _modalityIcon(widget.exercise.modality),
                        size: 14,
                        color: color,
                      ),
                      label: Text(widget.exercise.modality.label),
                      labelStyle: theme.textTheme.labelSmall?.copyWith(
                        color: color,
                      ),
                      backgroundColor: color.withValues(alpha: 0.12),
                      side: BorderSide.none,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    ),
                    if (widget.exercise.muscleGroup != null)
                      Chip(
                        label: Text(widget.exercise.muscleGroup!),
                        labelStyle: theme.textTheme.labelSmall?.copyWith(
                          color: tokens.muted,
                        ),
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        side: BorderSide.none,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                      ),
                    if (widget.exercise.equipment != null)
                      Chip(
                        label: Text(widget.exercise.equipment!),
                        labelStyle: theme.textTheme.labelSmall?.copyWith(
                          color: tokens.muted,
                        ),
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        side: BorderSide.none,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Stat boxes (only for strength) ───────────────────
                if (widget.exercise.modality == Modality.strength) ...[
                  Row(
                    children: [
                      Expanded(
                        child: _StatBox(
                          label: 'Estimated 1RM',
                          value: _estimated1rm > 0
                              ? _estimated1rm.toStringAsFixed(1)
                              : '—',
                          unit: _estimated1rm > 0 ? 'kg' : '',
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
                          sub: heaviestReps > 0 ? '$heaviestReps reps' : '',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],

                // ── Top set trend chart ──────────────────────────────
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

                // ── Recent history ───────────────────────────────────
                Text('Recent history', style: theme.textTheme.titleSmall),
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
                                'No history yet — log this exercise'
                                ' to get started.',
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
                                  modality: widget.exercise.modality,
                                  isLast: s == recentSets.last,
                                ),
                              )
                              .toList(),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Color _modalityColor(BrandTokens t, Modality m) => switch (m) {
    Modality.strength => t.push,
    Modality.bodyweight => t.legs,
    Modality.cardio => t.cardio,
    Modality.timed => t.pull,
  };

  IconData _modalityIcon(Modality m) => switch (m) {
    Modality.strength => PhosphorIconsRegular.barbell,
    Modality.bodyweight => PhosphorIconsRegular.personSimple,
    Modality.cardio => PhosphorIconsRegular.personSimpleRun,
    Modality.timed => PhosphorIconsRegular.timer,
  };
}

// ── Stat box ───────────────────────────────────────────────────────────

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.label,
    required this.value,
    required this.unit,
    this.sub = '',
  });

  final String label;
  final String value;
  final String unit;
  final String sub;

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
          if (sub.isNotEmpty) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: tokens.accentSoft,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                sub,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: tokens.accent,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Top set chart ──────────────────────────────────────────────────────

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

// ── History row ────────────────────────────────────────────────────────

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({
    required this.set,
    required this.modality,
    required this.isLast,
  });

  final RawSet set;
  final Modality modality;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    final dayStr = DateFormat('EEE d MMM').format(set.sessionDate);
    final detail = _setDetail();

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
              if (detail.isNotEmpty)
                Text(
                  detail,
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

  String _setDetail() {
    final m = set.metrics;
    return switch (modality) {
      Modality.strength => () {
        final w = m['weight'];
        final r = m['reps'];
        if (w == null || r == null) return '';
        final wStr = w.truncateToDouble() == w
            ? w.toInt().toString()
            : w.toStringAsFixed(1);
        return '$wStr kg · ${r.toInt()} reps';
      }(),
      Modality.bodyweight => () {
        final r = m['reps'];
        return r != null ? '${r.toInt()} reps' : '';
      }(),
      Modality.cardio => () {
        final d = m['distanceKm'];
        final t = m['timeMin'];
        if (d != null && t != null) {
          return '${d.toStringAsFixed(1)} km · ${t.toInt()} min';
        }
        return '';
      }(),
      Modality.timed => () {
        final t = m['timeMin'];
        return t != null ? '${t.toInt()} min' : '';
      }(),
    };
  }
}
