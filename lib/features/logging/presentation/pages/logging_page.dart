import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/enums/equipment_type.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/notifications/notification_service.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/logging/domain/entities/exercise_entry.dart';
import 'package:momentum/features/logging/domain/entities/last_session_summary.dart';
import 'package:momentum/features/logging/domain/entities/set_row.dart';
import 'package:momentum/features/logging/domain/repositories/logging_repository.dart';
import 'package:momentum/features/logging/presentation/bloc/session_bloc.dart';
import 'package:momentum/features/logging/presentation/bloc/session_event.dart';
import 'package:momentum/features/logging/presentation/bloc/session_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// ── Route args ───────────────────────────────────────────────────────────────

class StartSessionArgs {
  const StartSessionArgs({
    this.planId,
    this.dayIndex,
    this.planTotalDays,
    this.focus,
    this.exercises = const [],
  });

  final int? planId;
  final int? dayIndex;
  final int? planTotalDays;
  final String? focus;
  final List<ExerciseEntry> exercises;
}

// ── Page ─────────────────────────────────────────────────────────────────────

class LoggingPage extends StatelessWidget {
  const LoggingPage({this.args, super.key});

  final StartSessionArgs? args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc =
            SessionBloc(
              repo: getIt<LoggingRepository>(),
              notifications: getIt<NotificationService>(),
            )..add(
              SessionEvent.started(
                exercises: args?.exercises ?? [],
                planId: args?.planId,
                dayIndex: args?.dayIndex,
                planTotalDays: args?.planTotalDays,
                focus: args?.focus,
              ),
            );
        return bloc;
      },
      child: const _SessionView(),
    );
  }
}

// ── Top-level view ───────────────────────────────────────────────────────────

class _SessionView extends StatelessWidget {
  const _SessionView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionBloc, SessionState>(
      listenWhen: (prev, curr) =>
          curr is SessionFinished || curr is SessionError,
      listener: (context, state) {
        switch (state) {
          case SessionFinished():
            Navigator.of(context).pop();
          case SessionError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          default:
            break;
        }
      },
      builder: (context, state) => switch (state) {
        SessionIdle() || SessionSaving() => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        SessionError(:final message) => Scaffold(
          body: Center(child: Text(message)),
        ),
        SessionFinished() => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        SessionActive() => const _ActiveSessionScaffold(),
      },
    );
  }
}

// ── Active session scaffold ──────────────────────────────────────────────────

class _ActiveSessionScaffold extends StatelessWidget {
  const _ActiveSessionScaffold();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SessionBloc>().state as SessionActive;

    return BlocListener<SessionBloc, SessionState>(
      listenWhen: (prev, cur) =>
          prev is SessionActive &&
          cur is SessionActive &&
          prev.celebrationExercise == null &&
          cur.celebrationExercise != null,
      listener: (ctx, s) => HapticFeedback.heavyImpact(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(9),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(color: context.brandTokens.line),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                tooltip: 'Close workout',
                icon: const Icon(PhosphorIconsRegular.x, size: 18),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          title: _StopwatchChip(state: state),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 38),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _confirmFinish(context),
                child: const Text('Finish'),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                _SessionProgressHeader(
                  focus: state.focus ?? 'Freestyle',
                  exercises: state.exercises,
                ),
                Expanded(
                  child: _ExerciseList(
                    exercises: state.exercises,
                    onAdd: () => _showAddExerciseDialog(context),
                  ),
                ),
              ],
            ),
            if (state.celebrationExercise != null)
              _PrCelebrationBanner(
                exerciseName: state.celebrationExercise!,
              ),
            if (state.restSecondsLeft != null)
              _RestTimerBanner(
                secondsLeft: state.restSecondsLeft!,
                total: state.restSecondsTotal ?? state.restSecondsLeft!,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmFinish(BuildContext context) async {
    final bloc = context.read<SessionBloc>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Finish workout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Finish'),
          ),
        ],
      ),
    );
    if (ok == true) {
      bloc.add(const SessionEvent.finishRequested());
    }
  }

  Future<void> _showAddExerciseDialog(BuildContext context) async {
    final bloc = context.read<SessionBloc>();
    final nameCtrl = TextEditingController();
    var modality = Modality.strength;
    EquipmentType? equipment;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Add exercise'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameCtrl,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Exercise name'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<Modality>(
                  initialValue: modality,
                  decoration: const InputDecoration(labelText: 'Modality'),
                  items: Modality.values
                      .map(
                        (m) => DropdownMenuItem(
                          value: m,
                          child: Text(m.name),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => modality = v!),
                ),
                const SizedBox(height: 12),
                Text(
                  'Equipment',
                  style: Theme.of(ctx).textTheme.labelMedium,
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: EquipmentType.values.map((e) {
                    return ChoiceChip(
                      label: Text(e.label),
                      selected: equipment == e,
                      onSelected: (v) =>
                          setState(() => equipment = v ? e : null),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final name = nameCtrl.text.trim();
                if (name.isEmpty) {
                  return;
                }
                Navigator.of(ctx).pop();
                final uid = DateTime.now().microsecondsSinceEpoch.toString();
                final firstSetId = '${uid}_0';
                bloc.add(
                  SessionEvent.adhocExerciseAdded(
                    ExerciseEntry(
                      localId: uid,
                      name: name,
                      modality: modality,
                      equipment: equipment,
                      sets: [
                        SetRow(
                          localId: firstSetId,
                          metrics: _defaultMetrics(modality),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  static Map<String, double> _defaultMetrics(Modality m) => switch (m) {
    Modality.strength => {'weight': 0, 'reps': 0},
    Modality.bodyweight => {'reps': 0},
    Modality.cardio => {'distanceKm': 0, 'timeMin': 0},
    Modality.timed => {'timeMin': 0},
  };
}

// ── Session progress header ──────────────────────────────────────────────────

class _SessionProgressHeader extends StatelessWidget {
  const _SessionProgressHeader({
    required this.focus,
    required this.exercises,
  });

  final String focus;
  final List<ExerciseEntry> exercises;

  @override
  Widget build(BuildContext context) {
    final total = exercises.fold<int>(0, (s, e) => s + e.sets.length);
    final done = exercises.fold<int>(
      0,
      (s, e) => s + e.sets.where((r) => r.isDone).length,
    );
    final progress = total > 0 ? done / total : 0.0;
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                focus,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '$done of $total done',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: context.brandTokens.muted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        LinearProgressIndicator(
          value: progress,
          minHeight: 6,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
        ),
      ],
    );
  }
}

// ── PR celebration banner ────────────────────────────────────────────────────

class _PrCelebrationBanner extends StatefulWidget {
  const _PrCelebrationBanner({required this.exerciseName});

  final String exerciseName;

  @override
  State<_PrCelebrationBanner> createState() => _PrCelebrationBannerState();
}

class _PrCelebrationBannerState extends State<_PrCelebrationBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  Timer? _autoDismiss;

  @override
  void initState() {
    super.initState();
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    _ctrl = AnimationController(
      vsync: this,
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 340),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack));
    unawaited(_ctrl.forward());
    _autoDismiss = Timer(const Duration(seconds: 3), _dismiss);
  }

  void _dismiss() {
    if (!mounted) {
      return;
    }
    context.read<SessionBloc>().add(const SessionEvent.celebrationDismissed());
  }

  @override
  void dispose() {
    _autoDismiss?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Semantics(
        label: 'Personal record on ${widget.exerciseName}. Tap to dismiss.',
        button: true,
        child: SlideTransition(
          position: _slide,
          child: GestureDetector(
            onTap: _dismiss,
            child: Container(
              margin: EdgeInsets.fromLTRB(12, topPadding + 8, 12, 0),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD600), Color(0xFFFFA000)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD600).withValues(alpha: 0.45),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    PhosphorIconsFill.trophy,
                    color: Colors.black87,
                    size: 26,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Record!',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        Text(
                          widget.exerciseName,
                          style:
                              Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: Colors.black54,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    PhosphorIconsRegular.x,
                    size: 18,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Stopwatch chip ───────────────────────────────────────────────────────────

class _StopwatchChip extends StatefulWidget {
  const _StopwatchChip({required this.state});

  final SessionActive state;

  @override
  State<_StopwatchChip> createState() => _StopwatchChipState();
}

class _StopwatchChipState extends State<_StopwatchChip> {
  Timer? _ticker;
  int _elapsed = 0;

  @override
  void initState() {
    super.initState();
    _update();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _update());
  }

  @override
  void didUpdateWidget(_StopwatchChip old) {
    super.didUpdateWidget(old);
    _update();
  }

  void _update() {
    if (!mounted) {
      return;
    }
    setState(() => _elapsed = _computeElapsed());
  }

  int _computeElapsed() {
    final s = widget.state;
    final started = s.stopwatchStartedAt;
    if (started == null) {
      return 0;
    }
    final now = DateTime.now();
    final totalMs = now.difference(started).inMilliseconds;
    final pausedMs =
        s.totalPausedMs +
        (s.stopwatchPausedAt != null
            ? now.difference(s.stopwatchPausedAt!).inMilliseconds
            : 0);
    return ((totalMs - pausedMs) / 1000).round().clamp(0, 99999);
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = _elapsed ~/ 3600;
    final m = (_elapsed % 3600) ~/ 60;
    final s = _elapsed % 60;
    final label = h > 0
        ? '${h.toString().padLeft(2, '0')}:'
              '${m.toString().padLeft(2, '0')}:'
              '${s.toString().padLeft(2, '0')}'
        : '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: () => context.read<SessionBloc>().add(
        const SessionEvent.stopwatchToggled(),
      ),
      child: Chip(
        avatar: Icon(
          widget.state.stopwatchRunning
              ? PhosphorIconsRegular.pauseCircle
              : PhosphorIconsRegular.playCircle,
          size: 18,
        ),
        label: Text(label),
      ),
    );
  }
}

// ── Exercise list ────────────────────────────────────────────────────────────

class _ExerciseList extends StatelessWidget {
  const _ExerciseList({required this.exercises, required this.onAdd});

  final List<ExerciseEntry> exercises;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 36, 20, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add an exercise to begin.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.brandTokens.muted,
              ),
            ),
            const SizedBox(height: 18),
            _AddExerciseButton(onPressed: onAdd),
          ],
        ),
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
      footer: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: _AddExerciseButton(onPressed: onAdd),
      ),
      itemCount: exercises.length,
      onReorder: (oldIndex, newIndex) {
        context.read<SessionBloc>().add(
          SessionEvent.exerciseReordered(
            oldIndex: oldIndex,
            newIndex: newIndex,
          ),
        );
      },
      itemBuilder: (context, i) {
        final ex = exercises[i];
        return _ExerciseCard(
          key: ValueKey(ex.localId),
          exercise: ex,
          index: i,
        );
      },
    );
  }
}

class _AddExerciseButton extends StatelessWidget {
  const _AddExerciseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(PhosphorIconsRegular.plus, size: 18),
        label: const Text('Add another exercise'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          minimumSize: const Size.fromHeight(50),
          side: BorderSide(color: context.brandTokens.line2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

// ── Exercise card ────────────────────────────────────────────────────────────

class _ExerciseCard extends StatefulWidget {
  const _ExerciseCard({
    required this.exercise,
    required this.index,
    super.key,
  });

  final ExerciseEntry exercise;
  final int index;

  @override
  State<_ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<_ExerciseCard> {
  late Future<LastSessionSummary?> _summaryFuture;

  @override
  void initState() {
    super.initState();
    _summaryFuture = _fetchSummary(widget.exercise.name);
  }

  @override
  void didUpdateWidget(_ExerciseCard old) {
    super.didUpdateWidget(old);
    if (old.exercise.name != widget.exercise.name) {
      _summaryFuture = _fetchSummary(widget.exercise.name);
    }
  }

  Future<LastSessionSummary?> _fetchSummary(String name) async {
    final result = await getIt<LoggingRepository>()
        .getLastSessionSummary(name)
        .run();
    final summary = result.getOrElse((_) => null);
    if (summary != null && summary.setMetrics.isNotEmpty && mounted) {
      context.read<SessionBloc>().add(
        SessionEvent.exercisePreFilled(
          exerciseLocalId: widget.exercise.localId,
          setMetrics: summary.setMetrics,
        ),
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    final bloc = context.read<SessionBloc>();
    final isPr = exercise.isPrHighlighted;
    final tokens = context.brandTokens;
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        border: Border.all(
          color: isPr ? tokens.good.withValues(alpha: 0.7) : tokens.line,
          width: isPr ? 1.5 : 1,
        ),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 6, 6),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            exercise.name,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (isPr) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: tokens.goodSoft,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'PR',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: tokens.good,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      // Last-session summary chip
                      FutureBuilder<LastSessionSummary?>(
                        future: _summaryFuture,
                        builder: (context, snap) {
                          final s = snap.data;
                          if (s == null) return const SizedBox.shrink();
                          final setLabel = s.setCount == 1 ? 'set' : 'sets';
                          final parts = <String>[
                            '${s.setCount} $setLabel',
                          ];
                          if (s.maxWeightKg != null) {
                            parts.add(
                              '${s.maxWeightKg!.toStringAsFixed(1)} kg max',
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              'Last time: ${parts.join(' · ')}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: tokens.muted,
                              ),
                            ),
                          );
                        },
                      ),
                      if (exercise.equipment != null)
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            exercise.equipment!.shortLabel,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    exercise.isCollapsed
                        ? PhosphorIconsRegular.caretDown
                        : PhosphorIconsRegular.caretUp,
                    size: 20,
                  ),
                  onPressed: () => bloc.add(
                    SessionEvent.exerciseToggled(exercise.localId),
                  ),
                ),
                ReorderableDragStartListener(
                  index: widget.index,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(PhosphorIconsRegular.dotsSixVertical, size: 20),
                  ),
                ),
              ],
            ),
          ),
          if (!exercise.isCollapsed) ...[
            _EquipmentPicker(exercise: exercise),
            if (exercise.sets.isNotEmpty)
              _SetHeader(modality: exercise.modality),
            ...exercise.sets.asMap().entries.map(
              (entry) => _SetRowWidget(
                setNumber: entry.key + 1,
                row: entry.value,
                modality: exercise.modality,
                exerciseLocalId: exercise.localId,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 0),
              child: OutlinedButton.icon(
                onPressed: () =>
                    bloc.add(SessionEvent.setAdded(exercise.localId)),
                icon: const Icon(PhosphorIconsRegular.plus, size: 18),
                label: const Text('Add set'),
              ),
            ),
            _TargetField(exercise: exercise),
            _ExerciseNoteField(exercise: exercise),
          ],
        ],
      ),
    );
  }
}

// ── Equipment picker ─────────────────────────────────────────────────────────

class _EquipmentPicker extends StatelessWidget {
  const _EquipmentPicker({required this.exercise});

  final ExerciseEntry exercise;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionBloc>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 2, 0, 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: EquipmentType.values.map((e) {
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: ChoiceChip(
                label: Text(e.shortLabel),
                selected: exercise.equipment == e,
                visualDensity: VisualDensity.compact,
                onSelected: (v) => bloc.add(
                  SessionEvent.exerciseEquipmentChanged(
                    exerciseLocalId: exercise.localId,
                    equipment: v ? e : null,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ── Exercise note field ──────────────────────────────────────────────────────

class _ExerciseNoteField extends StatefulWidget {
  const _ExerciseNoteField({required this.exercise});

  final ExerciseEntry exercise;

  @override
  State<_ExerciseNoteField> createState() => _ExerciseNoteFieldState();
}

class _ExerciseNoteFieldState extends State<_ExerciseNoteField> {
  late final TextEditingController _ctrl;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.exercise.exerciseNote ?? '');
  }

  @override
  void didUpdateWidget(_ExerciseNoteField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_editing &&
        oldWidget.exercise.exerciseNote != widget.exercise.exerciseNote) {
      _ctrl.text = widget.exercise.exerciseNote ?? '';
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _commit() {
    final note = _ctrl.text.trim();
    context.read<SessionBloc>().add(
      SessionEvent.exerciseNoteChanged(
        exerciseLocalId: widget.exercise.localId,
        note: note.isEmpty ? null : note,
      ),
    );
    setState(() => _editing = false);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    final theme = Theme.of(context);
    final hasNote = (widget.exercise.exerciseNote ?? '').isNotEmpty;

    if (!_editing && !hasNote) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 14, 8),
        child: TextButton.icon(
          onPressed: () => setState(() {
            _ctrl.clear();
            _editing = true;
          }),
          icon: Icon(
            PhosphorIconsRegular.notePencil,
            size: 16,
            color: tokens.muted,
          ),
          label: Text(
            'Add note',
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
          ),
        ),
      );
    }

    if (!_editing) {
      return GestureDetector(
        onTap: () => setState(() => _editing = true),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 2, 14, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  PhosphorIconsRegular.note,
                  size: 14,
                  color: tokens.muted,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.exercise.exerciseNote!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.muted,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
      child: TextField(
        controller: _ctrl,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        maxLines: null,
        style: theme.textTheme.bodySmall,
        decoration: InputDecoration(
          hintText: 'Note for this exercise…',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: IconButton(
            icon: const Icon(PhosphorIconsRegular.check, size: 16),
            onPressed: _commit,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ),
        onSubmitted: (_) => _commit(),
      ),
    );
  }
}

// ── Target field ─────────────────────────────────────────────────────────────

class _TargetField extends StatefulWidget {
  const _TargetField({required this.exercise});

  final ExerciseEntry exercise;

  @override
  State<_TargetField> createState() => _TargetFieldState();
}

class _TargetFieldState extends State<_TargetField> {
  late TextEditingController _ctrl;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(
      text: widget.exercise.targetWeight?.toStringAsFixed(1) ?? '',
    );
  }

  @override
  void didUpdateWidget(_TargetField old) {
    super.didUpdateWidget(old);
    if (!_editing &&
        old.exercise.targetWeight != widget.exercise.targetWeight) {
      _ctrl.text = widget.exercise.targetWeight?.toStringAsFixed(1) ?? '';
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _commit() {
    final v = double.tryParse(_ctrl.text.trim());
    context.read<SessionBloc>().add(
      SessionEvent.exerciseTargetChanged(
        exerciseLocalId: widget.exercise.localId,
        targetWeight: v,
      ),
    );
    setState(() => _editing = false);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    final theme = Theme.of(context);
    final hasTarget = widget.exercise.targetWeight != null;

    if (!_editing && !hasTarget) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 14, 0),
        child: TextButton.icon(
          onPressed: () => setState(() {
            _ctrl.clear();
            _editing = true;
          }),
          icon: Icon(PhosphorIconsRegular.flag, size: 16, color: tokens.muted),
          label: Text(
            'Set target',
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
          ),
        ),
      );
    }

    if (!_editing) {
      return GestureDetector(
        onTap: () => setState(() => _editing = true),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 2, 14, 4),
          child: Row(
            children: [
              Icon(PhosphorIconsRegular.flag, size: 14, color: tokens.muted),
              const SizedBox(width: 6),
              Text(
                'Target: '
                '${widget.exercise.targetWeight!.toStringAsFixed(1)} kg',
                style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 4),
      child: TextField(
        controller: _ctrl,
        autofocus: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
        ],
        style: theme.textTheme.bodySmall,
        decoration: InputDecoration(
          hintText: 'Target weight (kg)',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixText: 'kg',
          suffixIcon: IconButton(
            icon: const Icon(PhosphorIconsRegular.check, size: 16),
            onPressed: _commit,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
        ),
        onSubmitted: (_) => _commit(),
      ),
    );
  }
}

// ── Set header ───────────────────────────────────────────────────────────────

class _SetHeader extends StatelessWidget {
  const _SetHeader({required this.modality});

  final Modality modality;

  @override
  Widget build(BuildContext context) {
    final labels = switch (modality) {
      Modality.strength => ['Set', 'kg', 'Reps', ''],
      Modality.bodyweight => ['Set', 'Reps', ''],
      Modality.cardio => ['Set', 'km', 'min', ''],
      Modality.timed => ['Set', 'min', ''],
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 2),
      child: Row(
        children: [
          const SizedBox(width: 36),
          ...labels.map((l) {
            if (l.isEmpty) {
              return const SizedBox(width: 40);
            }
            return Expanded(
              child: Text(
                l,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            );
          }),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}

// ── Set row ──────────────────────────────────────────────────────────────────

class _SetRowWidget extends StatelessWidget {
  const _SetRowWidget({
    required this.setNumber,
    required this.row,
    required this.modality,
    required this.exerciseLocalId,
  });

  final int setNumber;
  final SetRow row;
  final Modality modality;
  final String exerciseLocalId;

  static List<String> _metricKeys(Modality m) => switch (m) {
    Modality.strength => ['weight', 'reps'],
    Modality.bodyweight => ['reps'],
    Modality.cardio => ['distanceKm', 'timeMin'],
    Modality.timed => ['timeMin'],
  };

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionBloc>();
    final keys = _metricKeys(modality);
    final isDone = row.isDone;
    final theme = Theme.of(context);
    final tokens = context.brandTokens;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 3, 10, 3),
          child: Row(
            children: [
              // Set badge
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surfaceContainerHighest,
                ),
                child: Center(
                  child: Text(
                    '$setNumber',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isDone
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.outline,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Metric pills
              ...keys.map(
                (key) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: _MetricPill(
                      value: row.metrics[key] ?? 0,
                      isDone: isDone,
                      onChanged: (v) => bloc.add(
                        SessionEvent.setRowValue(
                          exerciseLocalId: exerciseLocalId,
                          setLocalId: row.localId,
                          metricKey: key,
                          value: v,
                        ),
                      ),
                      onStep: (delta) => bloc.add(
                        SessionEvent.stepRowValue(
                          exerciseLocalId: exerciseLocalId,
                          setLocalId: row.localId,
                          metricKey: key,
                          delta: delta,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Done toggle
              SizedBox(
                width: 36,
                height: 36,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 22,
                  tooltip: isDone ? 'Mark as not done' : 'Mark as done',
                  icon: Icon(
                    isDone
                        ? PhosphorIconsFill.checkCircle
                        : PhosphorIconsRegular.checkCircle,
                    color: isDone ? theme.colorScheme.primary : tokens.faint,
                  ),
                  onPressed: () {
                    if (!isDone) unawaited(HapticFeedback.mediumImpact());
                    bloc.add(
                      SessionEvent.rowToggled(
                        exerciseLocalId: exerciseLocalId,
                        setLocalId: row.localId,
                      ),
                    );
                  },
                ),
              ),
              // Delete
              SizedBox(
                width: 28,
                height: 36,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 16,
                  tooltip: 'Remove set',
                  icon: Icon(PhosphorIconsRegular.x, color: tokens.faint),
                  onPressed: () => bloc.add(
                    SessionEvent.setRemoved(
                      exerciseLocalId: exerciseLocalId,
                      setLocalId: row.localId,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Expandable extra/half-rep row (strength only)
        if (modality == Modality.strength)
          _ExtraRepRow(row: row, exerciseLocalId: exerciseLocalId),
      ],
    );
  }
}

// ── Metric pill (horizontal –|value|+) ───────────────────────────────────────

class _MetricPill extends StatefulWidget {
  const _MetricPill({
    required this.value,
    required this.isDone,
    required this.onChanged,
    required this.onStep,
  });

  final double value;
  final bool isDone;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onStep;

  @override
  State<_MetricPill> createState() => _MetricPillState();
}

class _MetricPillState extends State<_MetricPill> {
  late TextEditingController _ctrl;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: _format(widget.value));
  }

  @override
  void didUpdateWidget(_MetricPill old) {
    super.didUpdateWidget(old);
    if (!_hasFocus && old.value != widget.value) {
      _ctrl.text = _format(widget.value);
    }
  }

  static String _format(double v) =>
      v == v.truncateToDouble() ? v.toInt().toString() : v.toString();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final valueColor = widget.isDone
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface;

    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: widget.isDone
            ? tokens.primarySoft
            : theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: widget.isDone
              ? theme.colorScheme.primary.withValues(alpha: 0.4)
              : tokens.line,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Minus
          SizedBox(
            width: 26,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                onTap: () => widget.onStep(-1),
                child: Center(
                  child: Icon(
                    PhosphorIconsRegular.minus,
                    size: 13,
                    color: tokens.muted,
                  ),
                ),
              ),
            ),
          ),
          // Value text field
          Expanded(
            child: Focus(
              onFocusChange: (focused) {
                setState(() => _hasFocus = focused);
                if (!focused) {
                  final v = double.tryParse(_ctrl.text) ?? widget.value;
                  widget.onChanged(v);
                }
              },
              child: TextField(
                controller: _ctrl,
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d*'),
                  ),
                ],
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: valueColor,
                  fontSize: 13,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          // Plus
          SizedBox(
            width: 26,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                onTap: () => widget.onStep(1),
                child: Center(
                  child: Icon(
                    PhosphorIconsRegular.plus,
                    size: 13,
                    color: tokens.muted,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Extra / half-rep expandable row ──────────────────────────────────────────

class _ExtraRepRow extends StatelessWidget {
  const _ExtraRepRow({required this.row, required this.exerciseLocalId});

  final SetRow row;
  final String exerciseLocalId;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionBloc>();
    final isExpanded = row.isExpanded;

    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => bloc.add(
              SessionEvent.setRowExpanded(
                exerciseLocalId: exerciseLocalId,
                setLocalId: row.localId,
                expanded: !isExpanded,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Icon(
                    isExpanded
                        ? PhosphorIconsRegular.caretUp
                        : PhosphorIconsRegular.caretDown,
                    size: 16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  Text(
                    'Extra / half reps',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 8),
              child: Row(
                children: [
                  Expanded(
                    child: _LabelledStepper(
                      label: 'Extra reps',
                      value: (row.metrics['extraReps'] ?? 0).toInt(),
                      onStep: (delta) => bloc.add(
                        SessionEvent.stepRowValue(
                          exerciseLocalId: exerciseLocalId,
                          setLocalId: row.localId,
                          metricKey: 'extraReps',
                          delta: delta.toDouble(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LabelledStepper(
                      label: 'Half reps',
                      value: (row.metrics['halfReps'] ?? 0).toInt(),
                      onStep: (delta) => bloc.add(
                        SessionEvent.stepRowValue(
                          exerciseLocalId: exerciseLocalId,
                          setLocalId: row.localId,
                          metricKey: 'halfReps',
                          delta: delta.toDouble(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _LabelledStepper extends StatelessWidget {
  const _LabelledStepper({
    required this.label,
    required this.value,
    required this.onStep,
  });

  final String label;
  final int value;
  final ValueChanged<int> onStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Row(
          children: [
            IconButton(
              iconSize: 18,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              icon: const Icon(PhosphorIconsRegular.minus),
              onPressed: value > 0 ? () => onStep(-1) : null,
            ),
            Expanded(
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              iconSize: 18,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              icon: const Icon(PhosphorIconsRegular.plus),
              onPressed: () => onStep(1),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Rest timer banner (circular) ─────────────────────────────────────────────

class _RestTimerBanner extends StatelessWidget {
  const _RestTimerBanner({required this.secondsLeft, required this.total});

  final int secondsLeft;
  final int total;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionBloc>();
    final m = secondsLeft ~/ 60;
    final s = secondsLeft % 60;
    final label =
        '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    final progress = total > 0 ? secondsLeft / total : 0.0;
    final theme = Theme.of(context);
    final tokens = context.brandTokens;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        elevation: 10,
        color: theme.colorScheme.surface,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
            child: Row(
              children: [
                // Circular ring
                SizedBox(
                  width: 64,
                  height: 64,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: CustomPaint(
                          painter: _TimerRingPainter(
                            progress: progress,
                            trackColor:
                                theme.colorScheme.surfaceContainerHighest,
                            arcColor: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      Text(
                        label,
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                // Label
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rest',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Take a breather',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                // Buttons
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => bloc.add(
                        const SessionEvent.restTimerAdjusted(15),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('+15s'),
                    ),
                    const SizedBox(height: 6),
                    TextButton(
                      onPressed: () =>
                          bloc.add(const SessionEvent.restTimerSkipped()),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('Skip'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  const _TimerRingPainter({
    required this.progress,
    required this.trackColor,
    required this.arcColor,
  });

  final double progress;
  final Color trackColor;
  final Color arcColor;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 5.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = trackColor;
    canvas.drawCircle(center, radius, track);

    if (progress <= 0) {
      return;
    }

    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = arcColor;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_TimerRingPainter old) =>
      old.progress != progress || old.arcColor != arcColor;
}
