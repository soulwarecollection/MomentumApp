import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_day_detail.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/routines/presentation/cubits/plan_editor_cubit.dart';
import 'package:momentum/features/routines/presentation/cubits/plan_editor_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PlanEditorPage extends StatelessWidget {
  const PlanEditorPage({required this.planId, super.key});

  final int planId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = PlanEditorCubit(
          repo: getIt<RoutinesRepository>(),
          planId: planId,
        );
        unawaited(cubit.init());
        return cubit;
      },
      child: const _EditorView(),
    );
  }
}

class _EditorView extends StatelessWidget {
  const _EditorView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanEditorCubit, PlanEditorState>(
      builder: (context, state) => switch (state) {
        PlanEditorInitial() || PlanEditorLoading() => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        PlanEditorError(:final message) => Scaffold(
          body: Center(child: Text(message)),
        ),
        PlanEditorLoaded(:final plan, :final days) => Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              onTap: () => _showRenameDialog(context, plan.name),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      plan.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(PhosphorIconsRegular.pencilSimple, size: 16),
                ],
              ),
            ),
            actions: [
              if (!plan.isActive)
                TextButton(
                  onPressed: () => _setActive(context),
                  child: const Text('Set active'),
                ),
              if (plan.isActive)
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Chip(label: Text('Active')),
                ),
            ],
          ),
          body: _DayList(days: days),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: FilledButton.icon(
                onPressed: () => _addDay(context),
                icon: const Icon(PhosphorIconsRegular.plus),
                label: const Text('Add day'),
              ),
            ),
          ),
        ),
      },
    );
  }

  void _showRenameDialog(BuildContext context, String currentName) {
    final cubit = context.read<PlanEditorCubit>();
    final controller = TextEditingController(text: currentName);
    unawaited(
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Rename plan'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final name = controller.text.trim();
                if (name.isEmpty) return;
                Navigator.of(ctx).pop();
                final result = await cubit.renamePlan(name);
                result.fold(
                  (f) {
                    if (!ctx.mounted) return;
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      SnackBar(content: Text(f.message)),
                    );
                  },
                  (_) {},
                );
              },
              child: const Text('Rename'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setActive(BuildContext context) async {
    final result = await context.read<PlanEditorCubit>().setActive();
    result.fold(
      (f) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(f.message)));
      },
      (_) {},
    );
  }

  Future<void> _addDay(BuildContext context) async {
    final cubit = context.read<PlanEditorCubit>();
    await _showDayDialog(context, cubit);
  }

  Future<void> _showDayDialog(
    BuildContext context,
    PlanEditorCubit cubit, {
    PlanDay? existing,
  }) async {
    final focusCtrl = TextEditingController(text: existing?.focus ?? '');
    var isRest = existing?.isRest ?? false;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(existing == null ? 'Add day' : 'Edit day'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: focusCtrl,
                autofocus: !isRest,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Focus (optional)',
                ),
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                value: isRest,
                onChanged: (v) => setState(() => isRest = v ?? false),
                title: const Text('Rest day'),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
                final focus = focusCtrl.text.trim();
                if (existing == null) {
                  await cubit.addDay(
                    isRest: isRest,
                    focus: focus.isEmpty ? null : focus,
                  );
                } else {
                  await cubit.editDay(
                    existing.copyWith(
                      focus: focus.isEmpty ? null : focus,
                      isRest: isRest,
                    ),
                  );
                }
              },
              child: Text(existing == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayList extends StatefulWidget {
  const _DayList({required this.days});

  final List<PlanDayDetail> days;

  @override
  State<_DayList> createState() => _DayListState();
}

class _DayListState extends State<_DayList> {
  final Set<int> _collapsedDayIds = {};

  @override
  Widget build(BuildContext context) {
    final days = widget.days;
    if (days.isEmpty) {
      return Center(
        child: Text(
          'No days yet — tap "Add day" below.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      );
    }

    final cubit = context.read<PlanEditorCubit>();
    return ReorderableListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      buildDefaultDragHandles: false,
      itemCount: days.length,
      onReorder: (oldIndex, newIndex) {
        final idx = newIndex > oldIndex ? newIndex - 1 : newIndex;
        final reordered = [...days];
        final moved = reordered.removeAt(oldIndex);
        reordered.insert(idx, moved);
        unawaited(
          cubit.reorderDays(
            reordered.map((d) => d.day.id).toList(),
          ),
        );
      },
      itemBuilder: (context, i) {
        final detail = days[i];
        return _DayCard(
          key: ValueKey(detail.day.id),
          detail: detail,
          dayNumber: i + 1,
          cubit: cubit,
          isCollapsed: _collapsedDayIds.contains(detail.day.id),
          onToggleCollapsed: () {
            setState(() {
              if (!_collapsedDayIds.remove(detail.day.id)) {
                _collapsedDayIds.add(detail.day.id);
              }
            });
          },
        );
      },
    );
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({
    required this.detail,
    required this.dayNumber,
    required this.cubit,
    required this.isCollapsed,
    required this.onToggleCollapsed,
    super.key,
  });

  final PlanDayDetail detail;
  final int dayNumber;
  final PlanEditorCubit cubit;
  final bool isCollapsed;
  final VoidCallback onToggleCollapsed;

  @override
  Widget build(BuildContext context) {
    final day = detail.day;
    final label = day.isRest
        ? 'Rest'
        : day.focus?.isNotEmpty == true
        ? day.focus!
        : 'Day $dayNumber';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: IconButton(
              icon: Icon(
                isCollapsed
                    ? PhosphorIconsRegular.caretDown
                    : PhosphorIconsRegular.caretUp,
              ),
              onPressed: onToggleCollapsed,
              tooltip: isCollapsed ? 'Expand workout' : 'Minimize workout',
            ),
            title: Text(
              'Day $dayNumber · $label',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isCollapsed) ...[
                  IconButton(
                    icon: const Icon(
                      PhosphorIconsRegular.pencilSimple,
                      size: 20,
                    ),
                    onPressed: () => _showDayDialog(context, cubit, day),
                    tooltip: 'Edit day',
                  ),
                  IconButton(
                    icon: const Icon(PhosphorIconsRegular.trash, size: 20),
                    onPressed: () => _confirmDelete(context, cubit, day),
                    tooltip: 'Delete day',
                  ),
                ],
                Tooltip(
                  message: 'Drag to reorder workout',
                  child: ReorderableDragStartListener(
                    index: dayNumber - 1,
                    child: const SizedBox.square(
                      dimension: 48,
                      child: Icon(PhosphorIconsRegular.dotsSixVertical),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!isCollapsed && !day.isRest) ...[
            if (detail.exercises.isNotEmpty)
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                buildDefaultDragHandles: false,
                itemCount: detail.exercises.length,
                onReorder: (oldIndex, newIndex) {
                  final idx = newIndex > oldIndex ? newIndex - 1 : newIndex;
                  final reordered = [...detail.exercises];
                  final moved = reordered.removeAt(oldIndex);
                  reordered.insert(idx, moved);
                  unawaited(
                    cubit.reorderExercises(
                      day.id,
                      reordered.map((e) => e.id).toList(),
                    ),
                  );
                },
                itemBuilder: (context, i) {
                  final ex = detail.exercises[i];
                  return _ExerciseItem(
                    key: ValueKey(ex.id),
                    exercise: ex,
                    index: i,
                    onEdit: () => _showExerciseDialog(
                      context,
                      cubit,
                      day.id,
                      existing: ex,
                    ),
                    onDelete: () async {
                      await cubit.deleteExercise(ex.id);
                    },
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: OutlinedButton.icon(
                onPressed: () => _showExerciseDialog(
                  context,
                  cubit,
                  day.id,
                ),
                icon: const Icon(PhosphorIconsRegular.plus, size: 18),
                label: const Text('Add exercise'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showDayDialog(
    BuildContext context,
    PlanEditorCubit cubit,
    PlanDay day,
  ) async {
    final focusCtrl = TextEditingController(text: day.focus ?? '');
    var isRest = day.isRest;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Edit day'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: focusCtrl,
                autofocus: !isRest,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Focus (optional)',
                ),
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                value: isRest,
                onChanged: (v) => setState(() => isRest = v ?? false),
                title: const Text('Rest day'),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
                final focus = focusCtrl.text.trim();
                await cubit.editDay(
                  day.copyWith(
                    focus: focus.isEmpty ? null : focus,
                    isRest: isRest,
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    PlanEditorCubit cubit,
    PlanDay day,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete day?'),
        content: const Text(
          'All exercises in this day will be removed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true) await cubit.deleteDay(day.id);
  }

  Future<void> _showExerciseDialog(
    BuildContext context,
    PlanEditorCubit cubit,
    int planDayId, {
    PlanExercise? existing,
  }) async {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final equipCtrl = TextEditingController(text: existing?.equipment ?? '');
    final setsCtrl = TextEditingController(
      text: existing?.targetSets?.toString() ?? '',
    );
    final schemeCtrl = TextEditingController(text: existing?.scheme ?? '');
    final targetCtrl = TextEditingController(text: existing?.target ?? '');

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          existing == null ? 'Add exercise' : 'Edit exercise',
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Exercise name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: equipCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Equipment'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: setsCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Target sets'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: schemeCtrl,
                decoration: const InputDecoration(
                  labelText: 'Scheme',
                  hintText: '3×8, AMRAP …',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: targetCtrl,
                decoration: const InputDecoration(
                  labelText: 'Target load',
                  hintText: '80 % 1RM, 75 kg …',
                ),
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
            onPressed: () async {
              final name = nameCtrl.text.trim();
              if (name.isEmpty) return;
              Navigator.of(ctx).pop();
              final sets = int.tryParse(setsCtrl.text.trim());
              final equip = equipCtrl.text.trim();
              final scheme = schemeCtrl.text.trim();
              final tgt = targetCtrl.text.trim();
              if (existing == null) {
                await cubit.addExercise(
                  planDayId,
                  name: name,
                  equipment: equip.isEmpty ? null : equip,
                  targetSets: sets,
                  scheme: scheme.isEmpty ? null : scheme,
                  target: tgt.isEmpty ? null : tgt,
                );
              } else {
                await cubit.editExercise(
                  existing.copyWith(
                    name: name,
                    equipment: equip.isEmpty ? null : equip,
                    targetSets: sets,
                    scheme: scheme.isEmpty ? null : scheme,
                    target: tgt.isEmpty ? null : tgt,
                  ),
                );
              }
            },
            child: Text(existing == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );
  }
}

class _ExerciseItem extends StatelessWidget {
  const _ExerciseItem({
    required this.exercise,
    required this.onEdit,
    required this.onDelete,
    required this.index,
    super.key,
  });

  final PlanExercise exercise;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int index;

  @override
  Widget build(BuildContext context) {
    final sub = [
      if (exercise.equipment != null) exercise.equipment!,
      if (exercise.targetSets != null) '${exercise.targetSets} sets',
      if (exercise.scheme != null) exercise.scheme!,
      if (exercise.target != null) exercise.target!,
    ].join(' · ');

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(exercise.name),
      subtitle: sub.isNotEmpty ? Text(sub) : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(PhosphorIconsRegular.pencilSimple, size: 18),
            onPressed: onEdit,
            tooltip: 'Edit',
          ),
          IconButton(
            icon: const Icon(PhosphorIconsRegular.trash, size: 18),
            onPressed: onDelete,
            tooltip: 'Delete',
          ),
          Tooltip(
            message: 'Drag to reorder exercise',
            child: ReorderableDragStartListener(
              index: index,
              child: const SizedBox.square(
                dimension: 40,
                child: Icon(PhosphorIconsRegular.dotsSixVertical, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
