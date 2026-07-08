import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_cubit.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_state.dart';

// ── Entry point ──────────────────────────────────────────────────────────────

Future<void> showWeightLogSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<WeightCubit>(),
        child: const _WeightLogSheet(),
      ),
    );

// ── Sheet ────────────────────────────────────────────────────────────────────

class _WeightLogSheet extends StatefulWidget {
  const _WeightLogSheet();

  @override
  State<_WeightLogSheet> createState() => _WeightLogSheetState();
}

class _WeightLogSheetState extends State<_WeightLogSheet> {
  final _ctrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  final _focusNode = FocusNode();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<WeightCubit>().state;
    if (state is WeightReady && state.latest != null) {
      _ctrl.text = state.latest!.weightKg.toStringAsFixed(1);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _noteCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final raw = double.tryParse(_ctrl.text.trim());
    if (raw == null || raw <= 0) return;
    setState(() => _saving = true);
    final note = _noteCtrl.text.trim();
    await context.read<WeightCubit>().add(
      raw,
      note: note.isEmpty ? null : note,
    );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    final theme = Theme.of(context);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(24, 16, 24, 160 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: tokens.line,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Log body weight',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _ctrl,
            focusNode: _focusNode,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d{0,2}'),
              ),
            ],
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              suffixText: 'kg',
              suffixStyle: theme.textTheme.titleLarge?.copyWith(
                color: tokens.muted,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onSubmitted: (_) => unawaited(_save()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _noteCtrl,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Note (optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<WeightCubit, WeightState>(
            builder: (context, state) {
              if (state is! WeightReady || state.entries.isEmpty) {
                return const SizedBox.shrink();
              }
              final recent = state.entries.take(5).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: tokens.muted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: recent
                          .map(
                            (e) => _HistoryChip(entry: e),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
          FilledButton(
            onPressed: _saving ? null : () => unawaited(_save()),
            child: _saving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _HistoryChip extends StatelessWidget {
  const _HistoryChip({required this.entry});
  final WeightEntryRow entry;

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    final theme = Theme.of(context);
    final date = DateFormat('MMM d').format(entry.recordedAt);

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          Text(
            '${entry.weightKg.toStringAsFixed(1)} kg',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            date,
            style: theme.textTheme.labelSmall?.copyWith(color: tokens.muted),
          ),
        ],
      ),
    );
  }
}
