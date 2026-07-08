import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_cubit.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_state.dart';
import 'package:momentum/features/weight/presentation/widgets/weight_log_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WeightSection extends StatelessWidget {
  const WeightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeightCubit, WeightState>(
      builder: (context, state) => switch (state) {
        WeightLoading() => const SizedBox(height: 180),
        WeightError() => const SizedBox.shrink(),
        WeightReady() => _WeightCard(state: state),
      },
    );
  }
}

class _WeightCard extends StatelessWidget {
  const _WeightCard({required this.state});
  final WeightReady state;

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
                      'Body Weight',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: tokens.muted,
                      ),
                    ),
                    if (state.latest != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        '${state.latest!.weightKg.toStringAsFixed(1)} kg',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ] else
                      Text(
                        'No entries yet',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: tokens.muted,
                        ),
                      ),
                  ],
                ),
              ),
              Semantics(
                label: 'Log body weight',
                button: true,
                child: IconButton.filledTonal(
                  onPressed: () => showWeightLogSheet(context),
                  icon: const Icon(PhosphorIconsRegular.plus),
                  tooltip: 'Log weight',
                ),
              ),
            ],
          ),
          if (state.chartPoints.length >= 2) ...[
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: _WeightLineChart(points: state.chartPoints),
            ),
          ],
        ],
      ),
    );
  }
}

class _WeightLineChart extends StatelessWidget {
  const _WeightLineChart({required this.points});
  final List<WeightEntryRow> points;

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;

    final weights = points.map((p) => p.weightKg).toList();
    final minY = weights.reduce((a, b) => a < b ? a : b);
    final maxY = weights.reduce((a, b) => a > b ? a : b);
    final range = (maxY - minY).clamp(1.0, double.infinity);

    final spots = points.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.weightKg);
    }).toList();

    final labelStyle = theme.textTheme.labelSmall?.copyWith(
      color: tokens.muted,
    );

    return LineChart(
      LineChartData(
        minY: minY - range * 0.15,
        maxY: maxY + range * 0.15,
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: range / 3,
          getDrawingHorizontalLine: (_) => FlLine(
            color: tokens.line.withValues(alpha: 0.5),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 44,
              interval: range / 3,
              getTitlesWidget: (value, _) => Text(
                value.toStringAsFixed(1),
                style: labelStyle,
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (points.length ~/ 4).clamp(1, 90).toDouble(),
              getTitlesWidget: (value, _) {
                final idx = value.toInt();
                if (idx < 0 || idx >= points.length) {
                  return const SizedBox.shrink();
                }
                return Text(
                  DateFormat('d MMM').format(points[idx].recordedAt),
                  style: labelStyle,
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.3,
            color: color,
            barWidth: 2.5,
            dotData: FlDotData(
              show: points.length <= 14,
              getDotPainter: (_, _, _, _) => FlDotCirclePainter(
                radius: 3,
                color: color,
              ),
            ),
            belowBarData: BarAreaData(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.withValues(alpha: 0.18),
                  color.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
