import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/progress/domain/entities/session_exercise_detail.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';
import 'package:momentum/features/progress/presentation/cubits/session_detail_cubit.dart';
import 'package:momentum/features/progress/presentation/cubits/session_detail_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SessionDetailPage extends StatelessWidget {
  const SessionDetailPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final c = SessionDetailCubit(GetIt.I<ProgressRepository>());
        unawaited(c.load(int.parse(id)));
        return c;
      },
      child: const _SessionDetailView(),
    );
  }
}

class _SessionDetailView extends StatelessWidget {
  const _SessionDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionDetailCubit, SessionDetailState>(
      builder: (context, state) => switch (state) {
        SessionDetailLoading() => Scaffold(
          appBar: AppBar(title: const Text('Session')),
          body: const Center(child: CircularProgressIndicator()),
        ),
        SessionDetailReady() => _ReadyBody(state: state),
        SessionDetailError(:final message) => Scaffold(
          appBar: AppBar(title: const Text('Session')),
          body: Center(child: Text(message)),
        ),
      },
    );
  }
}

class _ReadyBody extends StatelessWidget {
  const _ReadyBody({required this.state});

  final SessionDetailReady state;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);
    final s = state.summary;

    final dayStr = DateFormat('EEE, MMM d').format(s.startedAt);
    final dur = s.durationSeconds;
    final durStr = dur != null
        ? dur >= 3600
              ? '${dur ~/ 3600}h ${(dur % 3600) ~/ 60}m'
              : '${dur ~/ 60} min'
        : null;
    final meta = [dayStr, ?durStr].join(' · ');

    final vol = s.totalVolumeKg;
    final volStr = vol >= 1000
        ? '${(vol / 1000).toStringAsFixed(1)}k kg'
        : vol > 0
        ? '${vol.toStringAsFixed(0)} kg'
        : null;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: const Icon(PhosphorIconsRegular.arrowLeft),
              onPressed: () => context.pop(),
            ),
            title: const Text('Session'),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Text(
                  'Session',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: tokens.muted,
                  ),
                ),
                Text(
                  s.focus ?? 'Workout',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  meta,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: tokens.muted,
                  ),
                ),
                const SizedBox(height: 16),

                // ── Stat pills ─────────────────────────────────
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (s.setCount > 0)
                        _StatPill(
                          value: '${s.setCount}',
                          label: 'sets',
                        ),
                      if (volStr != null) ...[
                        const SizedBox(width: 8),
                        _StatPill(value: volStr, label: ''),
                      ],
                      if (durStr != null) ...[
                        const SizedBox(width: 8),
                        _StatPill(value: durStr, label: ''),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Exercise list ──────────────────────────────
                if (state.exercises.isNotEmpty) ...[
                  Text(
                    'Exercises',
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
                      children: state.exercises
                          .map(
                            (ex) => _ExerciseRow(
                              exercise: ex,
                              isLast: ex == state.exercises.last,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],

                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat pill ─────────────────────────────────────────────────────

class _StatPill extends StatelessWidget {
  const _StatPill({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(tokens.radiusLarge),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (label.isNotEmpty)
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
            ),
        ],
      ),
    );
  }
}

// ── Exercise row ──────────────────────────────────────────────────

class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({required this.exercise, required this.isLast});

  final SessionExerciseDetail exercise;
  final bool isLast;

  String _modalityIcon(Modality m) => switch (m) {
    Modality.strength => '🏋️',
    Modality.bodyweight => '💪',
    Modality.cardio => '🏃',
    Modality.timed => '⏱️',
  };

  String _setsLabel(SessionExerciseDetail ex) {
    if (ex.doneSets.isEmpty) return '';
    final parts = ex.doneSets
        .map((m) {
          final w = m['weight'];
          final r = m['reps'];
          if (w != null && r != null) {
            final wStr = w.toStringAsFixed(w.truncateToDouble() == w ? 0 : 1);
            return '$wStr × ${r.toInt()}';
          }
          final r2 = m['reps'];
          if (r2 != null) return '${r2.toInt()} reps';
          return '';
        })
        .where((s) => s.isNotEmpty);
    return parts.join(', ');
  }

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
                _modalityIcon(exercise.modality),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  exercise.name,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              Flexible(
                child: Text(
                  _setsLabel(exercise),
                  textAlign: TextAlign.end,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.muted,
                  ),
                  overflow: TextOverflow.ellipsis,
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
