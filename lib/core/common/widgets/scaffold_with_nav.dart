import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/enums/equipment_type.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/logging/domain/entities/exercise_entry.dart';
import 'package:momentum/features/logging/domain/entities/set_row.dart';
import 'package:momentum/features/logging/presentation/pages/logging_page.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ScaffoldWithNav extends StatelessWidget {
  const ScaffoldWithNav({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      extendBody: true,
      body: shell,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        height: 88 + bottomInset,
        elevation: 0,
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.scaffoldBackgroundColor.withValues(alpha: 0),
                theme.scaffoldBackgroundColor,
                theme.scaffoldBackgroundColor,
              ],
              stops: const [0, 0.38, 1],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, bottomInset + 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _NavItem(
                  icon: PhosphorIconsRegular.house,
                  label: 'Today',
                  index: 0,
                  current: shell.currentIndex,
                  onTap: () => shell.goBranch(
                    0,
                    initialLocation: shell.currentIndex == 0,
                  ),
                ),
                _NavItem(
                  icon: PhosphorIconsRegular.calendarBlank,
                  label: 'Plans',
                  index: 1,
                  current: shell.currentIndex,
                  onTap: () => shell.goBranch(
                    1,
                    initialLocation: shell.currentIndex == 1,
                  ),
                ),
                Expanded(
                  child: Semantics(
                    button: true,
                    label: 'Start training',
                    child: InkResponse(
                      onTap: () => _showQuickStart(context),
                      radius: 34,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 56,
                          height: 56,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(19),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.42,
                                ),
                                blurRadius: 26,
                                offset: const Offset(0, 10),
                                spreadRadius: -6,
                              ),
                            ],
                          ),
                          child: Icon(
                            PhosphorIconsRegular.plus,
                            size: 28,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _NavItem(
                  icon: PhosphorIconsRegular.chartBar,
                  label: 'Progress',
                  index: 2,
                  current: shell.currentIndex,
                  onTap: () => shell.goBranch(
                    2,
                    initialLocation: shell.currentIndex == 2,
                  ),
                ),
                _NavItem(
                  icon: PhosphorIconsRegular.user,
                  label: 'You',
                  index: 3,
                  current: shell.currentIndex,
                  onTap: () => shell.goBranch(
                    3,
                    initialLocation: shell.currentIndex == 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showQuickStart(BuildContext context) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        barrierColor: Colors.black.withValues(alpha: 0.55),
        builder: (_) => _QuickStartSheet(
          onScheduled: () {
            Navigator.of(context).pop();
            unawaited(_startScheduledWorkout(context));
          },
          onBrowse: () {
            Navigator.of(context).pop();
            unawaited(context.push('/library'));
          },
          onStart: (args) {
            Navigator.of(context).pop();
            unawaited(context.push('/log', extra: args));
          },
        ),
      ),
    );
  }

  Future<void> _startScheduledWorkout(BuildContext context) async {
    final routines = getIt<RoutinesRepository>();
    final schedule = getIt<ScheduleRepository>();
    final plansResult = await routines.watchPlans().first;
    final plans = plansResult.getOrElse((_) => const []);
    if (plans.isEmpty) {
      shell.goBranch(1, initialLocation: true);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Create a plan to start training.')),
        );
      }
      return;
    }

    final override = schedule.getOverride();
    var plan = plans.first;
    for (final candidate in plans) {
      if (candidate.id == override?.planId ||
          (override == null && candidate.isActive)) {
        plan = candidate;
        break;
      }
    }

    final daysResult = await routines.watchPlanDays(plan.id).first;
    final exercisesResult = await routines
        .watchAllExercisesForPlan(plan.id)
        .first;
    final days = daysResult.getOrElse((_) => const []);
    final allExercises = exercisesResult.getOrElse((_) => const []);
    if (days.isEmpty) {
      shell.goBranch(1, initialLocation: true);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Add a training day to this plan.')),
        );
      }
      return;
    }

    final dayIndex = (override?.dayIndex ?? plan.currentDayIndex).clamp(
      0,
      days.length - 1,
    );
    final day = days[dayIndex];
    final planExercises = allExercises.where(
      (exercise) => exercise.planDayId == day.id,
    );
    final entries = planExercises.map((exercise) {
      final setCount = exercise.targetSets ?? 3;
      return ExerciseEntry(
        localId: 'plan_${exercise.id}',
        name: exercise.name,
        modality: Modality.strength,
        equipment: EquipmentType.values.asNameMap()[exercise.equipment],
        sets: List.generate(
          setCount,
          (index) => SetRow(
            localId: 'plan_${exercise.id}_s$index',
            metrics: const {'weight': 0, 'reps': 0},
          ),
        ),
      );
    }).toList();

    if (!context.mounted) return;
    await context.push(
      '/log',
      extra: StartSessionArgs(
        planId: plan.id,
        dayIndex: dayIndex,
        planTotalDays: days.length,
        focus: day.focus,
        exercises: entries,
      ),
    );
  }
}

// ── Nav item ─────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final int index;
  final int current;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = index == current;
    final color = isActive
        ? theme.colorScheme.primary
        : context.brandTokens.faint;

    return Expanded(
      child: InkResponse(
        onTap: onTap,
        radius: 30,
        child: SizedBox(
          height: 54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(icon, color: color, size: 23),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Quick-start sheet ────────────────────────────────────────────────────────

class _QuickStartSheet extends StatelessWidget {
  const _QuickStartSheet({
    required this.onScheduled,
    required this.onBrowse,
    required this.onStart,
  });

  final VoidCallback onScheduled;
  final VoidCallback onBrowse;
  final void Function(StartSessionArgs args) onStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.92,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          8,
          20,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'Start training',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Use your plan, log freestyle, or browse exercises.',
              style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
            ),
            const SizedBox(height: 20),
            _StartTile(
              icon: PhosphorIconsRegular.play,
              color: theme.colorScheme.primary,
              title: 'Start scheduled workout',
              subtitle: 'From your active plan',
              feature: true,
              onTap: onScheduled,
            ),
            const SizedBox(height: 10),
            _StartTile(
              icon: PhosphorIconsRegular.magnifyingGlass,
              color: theme.colorScheme.onSurface,
              title: 'Browse exercises',
              subtitle: 'Search the full catalog',
              onTap: onBrowse,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  'OR LOG FREESTYLE',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: tokens.faint,
                    fontSize: 11,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
            _StartTile(
              icon: PhosphorIconsRegular.barbell,
              color: tokens.push,
              title: 'Strength',
              subtitle: 'Weight × reps, equipment, failure',
              onTap: () => onStart(
                const StartSessionArgs(
                  focus: 'Strength',
                ),
              ),
            ),
            const SizedBox(height: 10),
            _StartTile(
              icon: PhosphorIconsRegular.personSimpleRun,
              color: tokens.cardio,
              title: 'Cardio',
              subtitle: 'Distance · time · pace',
              onTap: () => onStart(
                const StartSessionArgs(
                  focus: 'Cardio',
                ),
              ),
            ),
            const SizedBox(height: 10),
            _StartTile(
              icon: PhosphorIconsRegular.personSimple,
              color: tokens.pull,
              title: 'Bodyweight',
              subtitle: 'Reps, progressions',
              onTap: () => onStart(
                const StartSessionArgs(
                  focus: 'Bodyweight',
                ),
              ),
            ),
            const SizedBox(height: 10),
            _StartTile(
              icon: PhosphorIconsRegular.timer,
              color: tokens.legs,
              title: 'Timed',
              subtitle: 'Holds, classes',
              onTap: () => onStart(
                const StartSessionArgs(
                  focus: 'Timed',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartTile extends StatelessWidget {
  const _StartTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.feature = false,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool feature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;

    return Material(
      color: feature ? tokens.primarySoft : theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(tokens.radiusCard),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(tokens.radiusCard),
            border: Border.all(color: tokens.line),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: feature
                      ? theme.colorScheme.primary
                      : color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: feature ? theme.colorScheme.onPrimary : color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: tokens.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                PhosphorIconsRegular.caretRight,
                size: 14,
                color: tokens.faint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
