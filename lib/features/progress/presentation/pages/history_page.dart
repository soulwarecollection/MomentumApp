import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/progress/domain/entities/heatmap_cell.dart';
import 'package:momentum/features/progress/domain/entities/session_summary.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';
import 'package:momentum/features/progress/presentation/cubits/history_cubit.dart';
import 'package:momentum/features/progress/presentation/cubits/history_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final c = HistoryCubit(GetIt.I<ProgressRepository>());
        unawaited(c.load());
        return c;
      },
      child: const _HistoryView(),
    );
  }
}

class _HistoryView extends StatelessWidget {
  const _HistoryView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) => switch (state) {
        HistoryLoading() => Scaffold(
          appBar: AppBar(title: const Text('History')),
          body: const Center(child: CircularProgressIndicator()),
        ),
        HistoryReady() => _ReadyBody(state: state),
        HistoryError(:final message) => Scaffold(
          appBar: AppBar(title: const Text('History')),
          body: Center(child: Text(message)),
        ),
      },
    );
  }
}

class _ReadyBody extends StatelessWidget {
  const _ReadyBody({required this.state});

  final HistoryReady state;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: const Icon(PhosphorIconsRegular.arrowLeft),
              onPressed: () => context.pop(),
            ),
            title: const Text('History'),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Text(
                  'Consistency',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: tokens.muted,
                  ),
                ),
                Text(
                  'History',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '12 weeks · the streak that builds momentum.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: tokens.muted,
                  ),
                ),
                const SizedBox(height: 14),

                // ── Heatmap ────────────────────────────────────
                _HeatmapCard(cells: state.heatmap),
                const SizedBox(height: 24),

                Text(
                  'All sessions',
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 8),

                if (state.sessions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text(
                        'No sessions yet.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: tokens.muted,
                        ),
                      ),
                    ),
                  )
                else
                  ...state.sessions.map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _SessionCard(session: s),
                    ),
                  ),

                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Heatmap ───────────────────────────────────────────────────────

class _HeatmapCard extends StatelessWidget {
  const _HeatmapCard({required this.cells});

  final List<HeatmapCell> cells;

  Color _heatColor(int count, ThemeData theme) => switch (count) {
    0 => theme.colorScheme.surfaceContainerHighest,
    1 => theme.colorScheme.primary.withValues(alpha: 0.28),
    2 => theme.colorScheme.primary.withValues(alpha: 0.52),
    3 => theme.colorScheme.primary.withValues(alpha: 0.78),
    _ => theme.colorScheme.primary,
  };

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);
    const weeks = 12;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final cellSize = (constraints.maxWidth - (weeks - 1) * 3) / weeks;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(weeks, (w) {
                  return Column(
                    children: List.generate(7, (d) {
                      final idx = w * 7 + d;
                      final count = idx < cells.length ? cells[idx].count : 0;
                      return Container(
                        width: cellSize,
                        height: cellSize,
                        margin: EdgeInsets.only(bottom: d < 6 ? 3 : 0),
                        decoration: BoxDecoration(
                          color: _heatColor(count, theme),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Less',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: tokens.muted,
                ),
              ),
              const SizedBox(width: 5),
              ...List.generate(5, (i) {
                return Container(
                  width: 11,
                  height: 11,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: _heatColor(i, theme),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
              Text(
                'More',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: tokens.muted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Session card ──────────────────────────────────────────────────

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});

  final SessionSummary session;

  Color _modalityColor(Modality? m, BrandTokens tokens) => switch (m) {
    Modality.strength => tokens.push,
    Modality.bodyweight => tokens.pull,
    Modality.cardio => tokens.cardio,
    Modality.timed => tokens.legs,
    null => tokens.muted,
  };

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    final dayStr = DateFormat('EEE').format(session.startedAt);
    final dur = session.durationSeconds;
    final durStr = dur != null
        ? dur >= 3600
              ? '${dur ~/ 3600}h ${(dur % 3600) ~/ 60}m'
              : '${dur ~/ 60} min'
        : null;
    final meta = [
      dayStr,
      ?durStr,
      if (session.setCount > 0) '${session.setCount} sets',
    ].join(' · ');

    final vol = session.totalVolumeKg;
    final volStr = vol >= 1000
        ? '${(vol / 1000).toStringAsFixed(1)}k'
        : vol > 0
        ? vol.toStringAsFixed(0)
        : null;

    return GestureDetector(
      onTap: () => unawaited(
        context.push('/progress/session/${session.id}'),
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
              height: 60,
              decoration: BoxDecoration(
                color: _modalityColor(session.dominantModality, tokens),
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
                    session.focus ?? 'Workout',
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
            if (volStr != null) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    volStr,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'kg',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tokens.muted,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
            ],
          ],
        ),
      ),
    );
  }
}
