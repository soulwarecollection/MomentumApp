import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum/core/common/widgets/error_state.dart';
import 'package:momentum/core/common/widgets/momentum_logo.dart';
import 'package:momentum/core/common/widgets/skeleton_box.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/enums/equipment_type.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/core/theme/theme_cubit.dart';
import 'package:momentum/features/goals/presentation/widgets/goal_progress_card.dart';
import 'package:momentum/features/logging/domain/entities/exercise_entry.dart';
import 'package:momentum/features/logging/domain/entities/set_row.dart';
import 'package:momentum/features/logging/presentation/pages/logging_page.dart';
import 'package:momentum/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/schedule/domain/entities/next_workout.dart';
import 'package:momentum/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:momentum/features/schedule/presentation/cubits/scheduler_cubit.dart';
import 'package:momentum/features/schedule/presentation/cubits/scheduler_state.dart';
import 'package:momentum/features/schedule/presentation/cubits/today_cubit.dart';
import 'package:momentum/features/schedule/presentation/cubits/today_state.dart';
import 'package:momentum/features/schedule/presentation/cubits/today_stats_cubit.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_cubit.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_state.dart';
import 'package:momentum/features/weight/presentation/widgets/weight_log_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// ── Helpers ──────────────────────────────────────────────────────────────────

void _pushStartWorkout(
  BuildContext context, {
  required NextWorkout nextWorkout,
  required int planTotalDays,
}) {
  final entries = _toExerciseEntries(nextWorkout.exercises);
  unawaited(
    context.push(
      '/log',
      extra: StartSessionArgs(
        planId: nextWorkout.plan.id,
        dayIndex: nextWorkout.dayIndex,
        planTotalDays: planTotalDays,
        focus: nextWorkout.day.focus,
        exercises: entries,
      ),
    ),
  );
}

List<ExerciseEntry> _toExerciseEntries(List<PlanExercise> planExercises) {
  return planExercises.map((pe) {
    final count = pe.targetSets ?? 3;
    return ExerciseEntry(
      localId: 'plan_${pe.id}',
      name: pe.name,
      modality: Modality.strength,
      equipment: EquipmentType.values.asNameMap()[pe.equipment],
      sets: List.generate(
        count,
        (i) => SetRow(
          localId: 'plan_${pe.id}_s$i',
          metrics: const {'weight': 0.0, 'reps': 0.0},
        ),
      ),
    );
  }).toList();
}

String _dateLabel(DateTime? date) {
  if (date == null) return 'Schedule';
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final d = DateTime(date.year, date.month, date.day);
  final diff = d.difference(today).inDays;
  if (diff < 0) return 'Overdue';
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Tomorrow';
  return 'In $diff days';
}

bool _isSameDay(DateTime? a, DateTime b) {
  if (a == null) return false;
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

Color _focusColor(String? focus, BrandTokens tokens) {
  if (focus == null) return tokens.push;
  final f = focus.toLowerCase();
  if (f.contains('push') ||
      f.contains('chest') ||
      f.contains('shoulder') ||
      f.contains('tri')) {
    return tokens.push;
  }
  if (f.contains('pull') ||
      f.contains('back') ||
      f.contains('bi') ||
      f.contains('row') ||
      f.contains('lat')) {
    return tokens.pull;
  }
  if (f.contains('leg') ||
      f.contains('squat') ||
      f.contains('dead') ||
      f.contains('lower')) {
    return tokens.legs;
  }
  if (f.contains('cardio') ||
      f.contains('run') ||
      f.contains('bike') ||
      f.contains('swim') ||
      f.contains('zone') ||
      f.contains('mobility')) {
    return tokens.cardio;
  }
  return tokens.push;
}

// ── Page ─────────────────────────────────────────────────────────────────────

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = getIt<AppDatabase>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TodayCubit(
            routinesRepo: getIt<RoutinesRepository>(),
            scheduleRepo: getIt<ScheduleRepository>(),
          )..init(),
        ),
        BlocProvider(
          create: (_) => TodayStatsCubit(
            dao: db.sessionsDao,
            onboardingRepo: getIt<OnboardingRepository>(),
          )..init(),
        ),
      ],
      child: const _TodayView(),
    );
  }
}

class _TodayView extends StatelessWidget {
  const _TodayView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mode = context.watch<ThemeCubit>().state;
    final isDark =
        mode == ThemeMode.dark ||
        (mode == ThemeMode.system && theme.brightness == Brightness.dark);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Row(
          children: [
            const MomentumLogo(size: 26),
            const SizedBox(width: 8),
            Text(
              'Momentum',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.35,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            width: 38,
            height: 38,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border.all(color: context.brandTokens.line),
              borderRadius: BorderRadius.circular(12),
              boxShadow: context.brandTokens.cardShadow,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 19,
              tooltip: isDark ? 'Use light theme' : 'Use dark theme',
              icon: Icon(
                isDark ? PhosphorIconsRegular.sun : PhosphorIconsRegular.moon,
              ),
              onPressed: () => unawaited(
                context.read<ThemeCubit>().setThemeMode(
                  isDark ? ThemeMode.light : ThemeMode.dark,
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TodayCubit, TodayState>(
        builder: (context, state) => switch (state) {
          TodayLoading() => const SkeletonList(itemHeight: 100),
          TodayNoActivePlan() => const _NoActivePlanBody(),
          TodayReady(:final nextWorkout, :final allDays) => _ReadyBody(
            nextWorkout: nextWorkout,
            allDays: allDays,
          ),
          TodayError(:final message) => ErrorStateWidget(message: message),
        },
      ),
    );
  }
}

// ── Empty state ──────────────────────────────────────────────────────────────

class _NoActivePlanBody extends StatelessWidget {
  const _NoActivePlanBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.barbell,
              size: 56,
              color: context.brandTokens.muted,
            ),
            const SizedBox(height: 16),
            Text(
              'No active plan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Create a plan in the Plans tab to get started.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.brandTokens.muted,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go('/plans'),
              child: const Text('Go to Plans'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Ready body ───────────────────────────────────────────────────────────────

class _ReadyBody extends StatelessWidget {
  const _ReadyBody({required this.nextWorkout, required this.allDays});

  final NextWorkout nextWorkout;
  final List<PlanDay> allDays;

  @override
  Widget build(BuildContext context) {
    final weekTotal = allDays.where((d) => !d.isRest).length;

    return BlocBuilder<TodayStatsCubit, TodayStatsState>(
      builder: (context, stats) {
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              sliver: SliverToBoxAdapter(child: _Greeting()),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              sliver: SliverToBoxAdapter(
                child: _MomentumHero(
                  weekDone: stats.weekDone,
                  weekTotal: weekTotal,
                  streak: stats.streak,
                  justOnboarded: stats.justOnboarded,
                ),
              ),
            ),
            if (stats.streakAtRisk)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: _StreakRiskBanner(
                    streak: stats.streak,
                    nextWorkout: nextWorkout,
                    planTotalDays: allDays.length,
                  ),
                ),
              ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
              sliver: SliverToBoxAdapter(child: _WeightTile()),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              sliver: SliverToBoxAdapter(child: GoalProgressCard()),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              sliver: SliverToBoxAdapter(
                child: _NextWorkoutCard(
                  nextWorkout: nextWorkout,
                  allDays: allDays,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 0, 0),
              sliver: SliverToBoxAdapter(
                child: _RotationSection(
                  nextWorkout: nextWorkout,
                  allDays: allDays,
                ),
              ),
            ),
            if (stats.recentSessions.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: _RecentSessionsSection(
                    sessions: stats.recentSessions,
                  ),
                ),
              ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
          ],
        );
      },
    );
  }
}

// ── Greeting ─────────────────────────────────────────────────────────────────

class _Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final greeting = now.hour < 12
        ? 'Good morning'
        : now.hour < 17
        ? 'Good afternoon'
        : 'Good evening';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('EEEE · d MMMM').format(now).toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: context.brandTokens.faint,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$greeting, Wageesha',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.55,
          ),
        ),
      ],
    );
  }
}

// ── Momentum hero (ring + streak) ────────────────────────────────────────────

class _MomentumHero extends StatelessWidget {
  const _MomentumHero({
    required this.weekDone,
    required this.weekTotal,
    required this.streak,
    required this.justOnboarded,
  });

  final int weekDone;
  final int weekTotal;
  final int streak;
  final bool justOnboarded;

  static const _justOnboardedRingFloor = 0.12;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final showOnboardedBoost = justOnboarded && weekDone == 0;
    final progress = weekTotal > 0
        ? (weekDone / weekTotal).clamp(0.0, 1.0)
        : 0.0;
    final displayProgress = showOnboardedBoost
        ? _justOnboardedRingFloor
        : progress;
    final pct = '${(displayProgress * 100).round()}%';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(tokens.radiusLarge),
        boxShadow: tokens.cardShadow,
        border: Border.all(color: tokens.line),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(100, 100),
                  painter: _RingPainter(
                    progress: displayProgress,
                    trackColor: theme.colorScheme.surfaceContainerHigh,
                    startColor: theme.colorScheme.primary,
                    endColor: tokens.accent,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      pct,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      'WEEK',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: tokens.muted,
                        letterSpacing: 0.1,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weekly momentum',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  showOnboardedBoost
                      ? 'Plan built — first session starts your week.'
                      : weekTotal > 0
                      ? '$weekDone of $weekTotal planned sessions done.'
                      : 'Start logging to build momentum.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.muted,
                    height: 1.5,
                  ),
                ),
                if (streak > 0) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        PhosphorIconsFill.fire,
                        size: 13,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$streak-day streak',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.startColor,
    required this.endColor,
  });

  final double progress;
  final Color trackColor;
  final Color startColor;
  final Color endColor;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 9.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = trackColor;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    final sweepAngle = 2 * math.pi * progress;
    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 3 * math.pi / 2,
      colors: [startColor, endColor, startColor],
      stops: const [0.0, 0.5, 1.0],
    );

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect);

    canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, arcPaint);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.startColor != startColor ||
      old.endColor != endColor;
}

// ── Next workout card ────────────────────────────────────────────────────────

class _NextWorkoutCard extends StatelessWidget {
  const _NextWorkoutCard({required this.nextWorkout, required this.allDays});

  final NextWorkout nextWorkout;
  final List<PlanDay> allDays;

  String _exercisePreview() {
    final exs = nextWorkout.exercises;
    if (exs.isEmpty) return 'No exercises planned';
    final names = exs.take(3).map((e) => e.name).join(' · ');
    if (exs.length <= 3) return names;
    return '$names  +${exs.length - 3} more';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final nw = nextWorkout;
    final isRest = nw.day.isRest;
    final dayLabel = (nw.day.focus?.isNotEmpty ?? false)
        ? nw.day.focus!
        : 'Day ${nw.dayIndex + 1}';

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        boxShadow: tokens.cardShadow,
        border: Border.all(color: tokens.line),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'NEXT WORKOUT',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: tokens.faint,
                  letterSpacing: 0.14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _openScheduler(context),
                child: Text(
                  'Change',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            nw.plan.name,
            style: theme.textTheme.bodySmall?.copyWith(
              color: tokens.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            isRest ? 'Rest Day' : dayLabel,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _DateChip(
                date: nw.scheduledDate,
                onTap: () => _openScheduler(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            isRest ? 'Recovery — no workout needed' : _exercisePreview(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: tokens.muted,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isRest ? null : () => _startWorkout(context),
              child: Text(isRest ? 'Rest day' : 'Start workout'),
            ),
          ),
        ],
      ),
    );
  }

  void _startWorkout(BuildContext context) {
    _pushStartWorkout(
      context,
      nextWorkout: nextWorkout,
      planTotalDays: allDays.length,
    );
  }

  void _openScheduler(BuildContext context) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (sheetCtx) => BlocProvider(
          create: (_) {
            final cubit = SchedulerCubit(
              routinesRepo: getIt<RoutinesRepository>(),
              scheduleRepo: getIt<ScheduleRepository>(),
            );
            unawaited(cubit.init());
            return cubit;
          },
          child: const _SchedulerSheet(),
        ),
      ),
    );
  }
}

// ── Streak near-miss banner ──────────────────────────────────────────────────

class _StreakRiskBanner extends StatelessWidget {
  const _StreakRiskBanner({
    required this.streak,
    required this.nextWorkout,
    required this.planTotalDays,
  });

  final int streak;
  final NextWorkout nextWorkout;
  final int planTotalDays;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    return GestureDetector(
      onTap: () => _pushStartWorkout(
        context,
        nextWorkout: nextWorkout,
        planTotalDays: planTotalDays,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              PhosphorIconsFill.fire,
              size: 18,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Log today to keep your $streak-day streak',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Icon(
              PhosphorIconsRegular.caretRight,
              size: 18,
              color: tokens.muted,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Date chip ────────────────────────────────────────────────────────────────

class _DateChip extends StatelessWidget {
  const _DateChip({required this.date, required this.onTap});

  final DateTime? date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final hasDate = date != null;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isFuture =
        date != null &&
        DateTime(date!.year, date!.month, date!.day).isAfter(today);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          color: isFuture
              ? tokens.accentSoft
              : hasDate
              ? tokens.primarySoft
              : null,
          border: Border.all(
            color: isFuture
                ? tokens.accent.withValues(alpha: 0.4)
                : theme.colorScheme.outline.withValues(alpha: 0.4),
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.calendarBlank,
              size: 13,
              color: isFuture ? tokens.accent : theme.colorScheme.primary,
            ),
            const SizedBox(width: 5),
            Text(
              _dateLabel(date),
              style: theme.textTheme.labelMedium?.copyWith(
                color: isFuture ? tokens.accent : theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Rotation strip ───────────────────────────────────────────────────────────

class _RotationSection extends StatelessWidget {
  const _RotationSection({required this.nextWorkout, required this.allDays});

  final NextWorkout nextWorkout;
  final List<PlanDay> allDays;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodayCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${nextWorkout.plan.name} rotation',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () => context.go('/plans'),
                child: Text(
                  'Plans',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _RotationStrip(
          days: allDays,
          nextDayIndex: nextWorkout.dayIndex,
          onDayTap: (i) => unawaited(cubit.setNextDay(i)),
        ),
      ],
    );
  }
}

class _RotationStrip extends StatefulWidget {
  const _RotationStrip({
    required this.days,
    required this.nextDayIndex,
    this.onDayTap,
  });

  final List<PlanDay> days;
  final int nextDayIndex;
  final void Function(int index)? onDayTap;

  @override
  State<_RotationStrip> createState() => _RotationStripState();
}

class _RotationStripState extends State<_RotationStrip> {
  late final ScrollController _sc;

  @override
  void initState() {
    super.initState();
    _sc = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_sc.hasClients) return;
      const pillWidth = 72.0;
      final offset = (widget.nextDayIndex * pillWidth).clamp(
        0.0,
        _sc.position.maxScrollExtent,
      );
      if (offset > 0) {
        unawaited(
          _sc.animateTo(
            offset,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: ListView.builder(
        controller: _sc,
        scrollDirection: Axis.horizontal,
        itemCount: widget.days.length,
        padding: const EdgeInsets.only(right: 16),
        itemBuilder: (context, i) {
          final day = widget.days[i];
          return GestureDetector(
            onTap: day.isRest ? null : () => widget.onDayTap?.call(i),
            child: _DayPill(
              day: day,
              dayNumber: i + 1,
              isNext: i == widget.nextDayIndex,
            ),
          );
        },
      ),
    );
  }
}

class _DayPill extends StatelessWidget {
  const _DayPill({
    required this.day,
    required this.dayNumber,
    required this.isNext,
  });

  final PlanDay day;
  final int dayNumber;
  final bool isNext;

  String get _label {
    if (day.isRest) return 'R';
    final f = day.focus;
    if (f == null || f.isEmpty) return 'D$dayNumber';
    return f.length > 4 ? f.substring(0, 4) : f;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : const Duration(milliseconds: 200),
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isNext
                  ? primary
                  : day.isRest
                  ? theme.colorScheme.surfaceContainerLow
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: isNext
                  ? null
                  : Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.25),
                    ),
            ),
            child: Center(
              child: Text(
                _label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isNext
                      ? theme.colorScheme.onPrimary
                      : day.isRest
                      ? tokens.faint
                      : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          if (isNext)
            Text(
              'NEXT',
              style: theme.textTheme.labelSmall?.copyWith(
                color: primary,
                fontWeight: FontWeight.w800,
                fontSize: 9,
                letterSpacing: 0.5,
              ),
            )
          else
            const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Recent sessions ──────────────────────────────────────────────────────────

class _RecentSessionsSection extends StatelessWidget {
  const _RecentSessionsSection({required this.sessions});

  final List<SessionRow> sessions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Recent sessions',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push('/progress/history'),
              child: Text(
                'History',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...sessions.map((s) => _SessionCard(session: s)),
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});

  final SessionRow session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final tagColor = _focusColor(session.focus, tokens);
    final focusLabel = session.focus?.isNotEmpty == true
        ? session.focus!
        : 'Freestyle';
    final dateStr = DateFormat('EEE · MMM d').format(session.startedAt);
    final durStr = session.durationSeconds != null
        ? _formatDuration(session.durationSeconds!)
        : '';
    final meta = [dateStr, if (durStr.isNotEmpty) durStr].join(' · ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => context.push('/progress/session/${session.id}'),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(tokens.radiusCard),
            boxShadow: tokens.cardShadow,
            border: Border.all(color: tokens.line),
          ),
          child: Row(
            children: [
              Container(
                width: 9,
                height: 58,
                decoration: BoxDecoration(
                  color: tagColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        focusLabel,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        meta,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.muted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                PhosphorIconsRegular.caretRight,
                color: tokens.faint,
                size: 20,
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    if (m < 60) return '$m min';
    final h = m ~/ 60;
    final rem = m % 60;
    return rem > 0 ? '${h}h ${rem}m' : '${h}h';
  }
}

// ── Scheduler sheet ──────────────────────────────────────────────────────────

class _SchedulerSheet extends StatelessWidget {
  const _SchedulerSheet();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.72,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (sheetCtx, scrollController) =>
          BlocBuilder<SchedulerCubit, SchedulerState>(
            builder: (context, state) => switch (state) {
              SchedulerLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              SchedulerError(:final message) => Center(child: Text(message)),
              SchedulerReady() => _SchedulerReadyBody(
                scrollController: scrollController,
                state: state,
              ),
            },
          ),
    );
  }
}

class _SchedulerReadyBody extends StatelessWidget {
  const _SchedulerReadyBody({
    required this.scrollController,
    required this.state,
  });

  final ScrollController scrollController;
  final SchedulerReady state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(top: 12, bottom: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.outline.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Plan your next workout',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.x),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
            children: [
              const _SectionLabel(label: 'When'),
              const SizedBox(height: 8),
              _WhenChips(scheduledDate: state.scheduledDate),
              if (state.plans.length > 1) ...[
                const SizedBox(height: 20),
                const _SectionLabel(label: 'Plan'),
                const SizedBox(height: 8),
                _PlanChips(
                  plans: state.plans,
                  selectedPlanId: state.selectedPlanId,
                ),
              ],
              const SizedBox(height: 20),
              const _SectionLabel(label: 'Which day'),
              const SizedBox(height: 4),
              _DayList(
                days: state.selectedPlanDays,
                selectedIndex: state.selectedDayIndex,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            20,
            12,
            20,
            MediaQuery.of(context).padding.bottom + 16,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.15),
              ),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                await context.read<SchedulerCubit>().save();
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Set as next workout'),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Scheduler sub-widgets ────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: context.brandTokens.muted,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _WhenChips extends StatelessWidget {
  const _WhenChips({required this.scheduledDate});

  final DateTime? scheduledDate;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SchedulerCubit>();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final options = <(String, DateTime)>[
      ('Today', today),
      ('Tomorrow', today.add(const Duration(days: 1))),
      ('In 2 days', today.add(const Duration(days: 2))),
      ('In 3 days', today.add(const Duration(days: 3))),
    ];

    final hasCustomDate =
        scheduledDate != null &&
        !options.any((o) => _isSameDay(scheduledDate, o.$2));

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final (label, date) in options)
          ChoiceChip(
            label: Text(label),
            selected: _isSameDay(scheduledDate, date),
            onSelected: (selected) {
              if (selected) cubit.changeDate(date);
            },
          ),
        ActionChip(
          avatar: const Icon(PhosphorIconsRegular.calendarBlank, size: 16),
          label: hasCustomDate
              ? Text(DateFormat('MMM d').format(scheduledDate!))
              : const Text('Pick date'),
          onPressed: () async {
            final result = await showDatePicker(
              context: context,
              initialDate: today.add(const Duration(days: 1)),
              firstDate: today,
              lastDate: today.add(const Duration(days: 365)),
            );
            if (result != null && context.mounted) {
              cubit.changeDate(result);
            }
          },
        ),
      ],
    );
  }
}

class _PlanChips extends StatelessWidget {
  const _PlanChips({required this.plans, required this.selectedPlanId});

  final List<Plan> plans;
  final int selectedPlanId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SchedulerCubit>();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final plan in plans)
          ChoiceChip(
            label: Text(plan.name),
            selected: plan.id == selectedPlanId,
            onSelected: (selected) {
              if (selected) unawaited(cubit.changePlan(plan.id));
            },
          ),
      ],
    );
  }
}

class _DayList extends StatelessWidget {
  const _DayList({required this.days, required this.selectedIndex});

  final List<PlanDay> days;
  final int selectedIndex;

  String _dayLabel(PlanDay day, int index) {
    if (day.focus?.isNotEmpty ?? false) return day.focus!;
    if (day.isRest) return 'Rest day';
    return 'Day ${index + 1}';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SchedulerCubit>();
    final theme = Theme.of(context);
    return Column(
      children: [
        for (int i = 0; i < days.length; i++)
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Icon(
              i == selectedIndex
                  ? PhosphorIconsFill.radioButton
                  : PhosphorIconsRegular.circle,
              size: 20,
              color: i == selectedIndex
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
            ),
            title: Text(_dayLabel(days[i], i)),
            subtitle: days[i].isRest
                ? Text(
                    'Rest',
                    style: TextStyle(
                      color: context.brandTokens.muted,
                      fontSize: 12,
                    ),
                  )
                : null,
            onTap: () => cubit.changeDay(i),
          ),
      ],
    );
  }
}

// ── Weight tile ──────────────────────────────────────────────────────────────

class _WeightTile extends StatelessWidget {
  const _WeightTile();

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    final theme = Theme.of(context);

    return BlocBuilder<WeightCubit, WeightState>(
      builder: (context, state) {
        final latest = state is WeightReady ? state.latest : null;
        final label = latest == null
            ? 'Tap to log'
            : '${latest.weightKg.toStringAsFixed(1)} kg';
        final sub = latest == null
            ? 'Body weight'
            : 'Body weight · ${DateFormat('MMM d').format(
                latest.recordedAt,
              )}';

        return GestureDetector(
          onTap: () => showWeightLogSheet(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: tokens.cardShadow,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    PhosphorIconsRegular.scales,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        sub,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  PhosphorIconsRegular.plusCircle,
                  color: theme.colorScheme.primary,
                  size: 22,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
