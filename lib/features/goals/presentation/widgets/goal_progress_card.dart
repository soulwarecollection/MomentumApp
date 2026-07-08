import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/core/enums/goal_type.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/goals/domain/entities/goal_progress.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_cubit.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_state.dart';
import 'package:momentum/features/goals/presentation/pages/goal_setup_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GoalProgressCard extends StatelessWidget {
  const GoalProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalCubit, GoalState>(
      builder: (context, state) => switch (state) {
        GoalLoading() => const SizedBox.shrink(),
        GoalNoGoal() => _EmptyGoalCard(
          onTap: () => showGoalSetupSheet(context),
        ),
        GoalActive(:final progress) => _GoalCard(progress: progress),
        GoalError() => const SizedBox.shrink(),
      },
    );
  }
}

// ── Empty state ──────────────────────────────────────────────────────────

class _EmptyGoalCard extends StatelessWidget {
  const _EmptyGoalCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(tokens.radiusCard),
          border: Border.all(color: tokens.line),
          boxShadow: tokens.cardShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                PhosphorIconsRegular.flag,
                size: 18,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Set a goal',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Track fat loss, weight gain, or a strength PR',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tokens.muted,
                    ),
                  ),
                ],
              ),
            ),
            Icon(PhosphorIconsRegular.plus, size: 20, color: tokens.muted),
          ],
        ),
      ),
    );
  }
}

// ── Active goal card ─────────────────────────────────────────────────────

class _GoalCard extends StatelessWidget {
  const _GoalCard({required this.progress});

  final GoalProgress progress;

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    final theme = Theme.of(context);
    final goal = progress.goal;

    final paceColor = progress.isComplete || progress.isOnPace
        ? tokens.good
        : theme.colorScheme.error;
    final progressPct = (progress.progressFraction * 100).toStringAsFixed(0);

    return GestureDetector(
      onTap: () => showGoalSetupSheet(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(tokens.radiusCard),
          border: Border.all(color: tokens.line),
          boxShadow: tokens.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Icon(PhosphorIconsRegular.flag, size: 15, color: tokens.muted),
                const SizedBox(width: 6),
                Text(
                  goal.type.label +
                      (goal.type == GoalType.strengthPr &&
                              goal.exerciseName != null
                          ? ' · ${goal.exerciseName}'
                          : ''),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: tokens.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (progress.isComplete)
                  _Chip(
                    label: 'Done!',
                    color: tokens.good,
                    bg: tokens.goodSoft,
                  )
                else
                  Text(
                    '${progress.daysRemaining}d left',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: tokens.muted,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress.progressFraction,
                minHeight: 6,
                backgroundColor: tokens.line2,
                valueColor: AlwaysStoppedAnimation<Color>(paceColor),
              ),
            ),
            const SizedBox(height: 10),
            // Stats row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$progressPct% of '
                        '${goal.targetValue.toStringAsFixed(1)} kg',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!progress.isComplete)
                        Text(
                          '${progress.gapValue.toStringAsFixed(1)} kg to go',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: tokens.muted,
                          ),
                        ),
                    ],
                  ),
                ),
                if (!progress.isComplete)
                  _Chip(
                    label: progress.isOnPace ? 'On pace' : 'Behind',
                    color: paceColor,
                    bg: paceColor.withValues(alpha: 0.12),
                  ),
              ],
            ),
            // Suggestion banner
            if (progress.suggestion != null) ...[
              const SizedBox(height: 10),
              _SuggestionBanner(suggestion: progress.suggestion!),
            ],
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.color,
    required this.bg,
  });

  final String label;
  final Color color;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SuggestionBanner extends StatelessWidget {
  const _SuggestionBanner({required this.suggestion});

  final GoalSuggestion suggestion;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = switch (suggestion) {
      GoalSuggestion.checkCalories =>
        'Weight has been flat for 5+ days — consider reviewing calorie intake.',
      GoalSuggestion.strengthBehind =>
        "You're behind pace on this lift — check your Progress tab.",
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(
              PhosphorIconsRegular.lightbulb,
              size: 14,
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(width: 6),
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
    );
  }
}
