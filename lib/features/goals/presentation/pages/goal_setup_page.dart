import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/enums/goal_type.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/goals/domain/entities/goal.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_cubit.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_state.dart';
import 'package:momentum/features/weight/domain/repositories/weight_repository.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Future<void> showGoalSetupSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (_) => BlocProvider.value(
      value: context.read<GoalCubit>(),
      child: const _GoalSetupSheet(),
    ),
  );
}

class _GoalSetupSheet extends StatefulWidget {
  const _GoalSetupSheet();

  @override
  State<_GoalSetupSheet> createState() => _GoalSetupSheetState();
}

class _GoalSetupSheetState extends State<_GoalSetupSheet> {
  GoalType _type = GoalType.fatLoss;
  DateTime _deadline = DateTime.now().add(const Duration(days: 90));
  bool _saving = false;

  final _targetCtrl = TextEditingController();
  final _exerciseCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill target from current goal if editing
    final state = getIt<GoalCubit>().state;
    if (state is GoalActive) {
      final goal = state.progress.goal;
      _type = goal.type;
      _deadline = goal.deadline;
      _targetCtrl.text = goal.targetValue.toStringAsFixed(1);
      if (goal.exerciseName != null) {
        _exerciseCtrl.text = goal.exerciseName!;
      }
    }
  }

  @override
  void dispose() {
    _targetCtrl.dispose();
    _exerciseCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final targetText = _targetCtrl.text.trim();
    if (targetText.isEmpty) return;
    if (_type == GoalType.strengthPr && _exerciseCtrl.text.trim().isEmpty) {
      return;
    }
    final targetValue = double.tryParse(targetText);
    if (targetValue == null || targetValue <= 0) return;

    setState(() => _saving = true);

    double? startValue;
    if (_type != GoalType.strengthPr) {
      final latest = await getIt<WeightRepository>().getLatest();
      startValue = latest?.weightKg;
    }

    if (!mounted) return;
    await context.read<GoalCubit>().setGoal(
      Goal(
        id: 0,
        type: _type,
        targetValue: targetValue,
        deadline: _deadline,
        createdAt: DateTime.now(),
        startValue: startValue,
        exerciseName: _type == GoalType.strengthPr
            ? _exerciseCtrl.text.trim()
            : null,
      ),
    );

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _clear() async {
    await context.read<GoalCubit>().clearGoal();
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final isEditing = context.read<GoalCubit>().state is GoalActive;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 12, 20, bottomInset + 160),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
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
            Row(
              children: [
                Expanded(
                  child: Text(
                    isEditing ? 'Edit goal' : 'Set a goal',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (isEditing)
                  TextButton(
                    onPressed: _saving ? null : _clear,
                    child: Text(
                      'Remove',
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Goals keep you on track between sessions.',
              style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
            ),
            const SizedBox(height: 20),
            // Goal type
            Text(
              'Goal type',
              style: theme.textTheme.labelMedium?.copyWith(
                color: tokens.muted,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: GoalType.values.map((t) {
                return ChoiceChip(
                  label: Text(t.label),
                  selected: _type == t,
                  onSelected: (v) {
                    if (v) setState(() => _type = t);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Exercise name (strength PR only)
            if (_type == GoalType.strengthPr) ...[
              TextField(
                controller: _exerciseCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Exercise name',
                  hintText: 'e.g. Bench Press',
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
            ],
            // Target value
            TextField(
              controller: _targetCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
              ],
              decoration: InputDecoration(
                labelText: _type == GoalType.strengthPr
                    ? 'Target 1RM (kg)'
                    : 'Target weight (kg)',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            // Deadline
            Text(
              'Deadline',
              style: theme.textTheme.labelMedium?.copyWith(
                color: tokens.muted,
              ),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _deadline,
                  firstDate: DateTime.now().add(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: 730)),
                );
                if (picked != null) setState(() => _deadline = picked);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: tokens.line2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      PhosphorIconsRegular.calendarBlank,
                      size: 16,
                      color: tokens.muted,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat('d MMMM yyyy').format(_deadline),
                      style: theme.textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Icon(
                      PhosphorIconsRegular.caretRight,
                      size: 18,
                      color: tokens.faint,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(isEditing ? 'Update goal' : 'Save goal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
