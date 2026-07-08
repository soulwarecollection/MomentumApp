import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/core/common/widgets/app_button.dart';
import 'package:momentum/core/common/widgets/app_card.dart';
import 'package:momentum/core/common/widgets/app_segmented_control.dart';
import 'package:momentum/core/common/widgets/stat_tile.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/core/theme/theme_cubit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Temporary visual regression page — compare against
/// design/momentum-prototype.html. Remove or gate behind a debug flag
/// before release.
class StyleguidePage extends StatefulWidget {
  const StyleguidePage({super.key});

  @override
  State<StyleguidePage> createState() => _StyleguidePageState();
}

class _StyleguidePageState extends State<StyleguidePage> {
  int _rangeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Style Guide'),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? PhosphorIconsRegular.sun
                  : PhosphorIconsRegular.moon,
            ),
            onPressed: () => unawaited(
              context.read<ThemeCubit>().setThemeMode(
                theme.brightness == Brightness.dark
                    ? ThemeMode.light
                    : ThemeMode.dark,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // ── Colours ────────────────────────────────────────────────────
          const _SectionHeader('Colours'),
          _ColorRow(label: 'Primary', color: cs.primary),
          _ColorRow(label: 'On-primary', color: cs.onPrimary),
          _ColorRow(label: 'Surface', color: cs.surface),
          _ColorRow(
            label: 'Bg (scaffold)',
            color: cs.surfaceContainerLowest,
          ),
          _ColorRow(
            label: 'Elevated',
            color: cs.surfaceContainerLow,
          ),
          _ColorRow(label: 'Muted text', color: tokens.muted),
          _ColorRow(label: 'Faint text', color: tokens.faint),
          _ColorRow(label: 'Good / success', color: tokens.good),
          _ColorRow(label: 'Accent', color: tokens.accent),
          _ColorRow(label: 'Error', color: cs.error),
          const SizedBox(height: 8),

          // Modality
          const _SectionHeader('Modality'),
          Row(
            children: [
              _ModalityChip(label: 'Push', color: tokens.push),
              const SizedBox(width: 8),
              _ModalityChip(label: 'Pull', color: tokens.pull),
              const SizedBox(width: 8),
              _ModalityChip(label: 'Legs', color: tokens.legs),
              const SizedBox(width: 8),
              _ModalityChip(label: 'Cardio', color: tokens.cardio),
            ],
          ),
          const SizedBox(height: 24),

          // ── Typography ─────────────────────────────────────────────────
          const _SectionHeader(
            'Typography — Space Grotesk (display / headline)',
          ),
          Text(
            'Display Lg — 57',
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 36),
          ),
          Text('Headline Lg — 32', style: theme.textTheme.headlineLarge),
          Text('Headline Md — 28', style: theme.textTheme.headlineMedium),
          Text('Headline Sm — 24', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          const _SectionHeader('Typography — Inter (body / label / title)'),
          Text('Title Large', style: theme.textTheme.titleLarge),
          Text('Title Medium', style: theme.textTheme.titleMedium),
          Text('Body Large', style: theme.textTheme.bodyLarge),
          Text('Body Medium', style: theme.textTheme.bodyMedium),
          Text('Body Small', style: theme.textTheme.bodySmall),
          Text('Label Large', style: theme.textTheme.labelLarge),
          Text('Label Small', style: theme.textTheme.labelSmall),
          const SizedBox(height: 24),

          // ── AppButton ──────────────────────────────────────────────────
          const _SectionHeader('AppButton'),
          AppButton(label: 'Start Workout', onPressed: () {}),
          const SizedBox(height: 8),
          AppButton(
            label: 'With icon',
            onPressed: () {},
            icon: const Icon(PhosphorIconsRegular.plus),
          ),
          const SizedBox(height: 8),
          const AppButton(label: 'Loading…', onPressed: null, loading: true),
          const SizedBox(height: 24),

          // ── AppCard + StatTile ─────────────────────────────────────────
          const _SectionHeader('AppCard + StatTile'),
          const AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatTile(value: '82.5', unit: 'kg', label: 'Weight'),
                StatTile(value: '8', label: 'Reps'),
                StatTile(value: '3', unit: '/', label: 'Sets'),
                StatTile(value: '142', unit: 'vol', label: 'Volume'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          AppCard(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 9,
                  height: 34,
                  decoration: BoxDecoration(
                    color: tokens.push,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bench Press',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Barbell · Push',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                const StatTile(value: '100', unit: 'kg', label: '1RM est.'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Segmented Control ──────────────────────────────────────────
          const _SectionHeader('AppSegmentedControl'),
          AppSegmentedControl(
            segments: const ['1M', '3M', '6M', '1Y'],
            selectedIndex: _rangeIndex,
            onSelected: (i) => setState(() => _rangeIndex = i),
          ),
          const SizedBox(height: 24),

          // ── Surfaces + borders ─────────────────────────────────────────
          const _SectionHeader('Surfaces + borders'),
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              border: Border.all(color: tokens.line),
              borderRadius: BorderRadius.circular(tokens.radiusCard),
            ),
            alignment: Alignment.center,
            child: Text(
              'surfaceContainerLow + line border',
              style: theme.textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: tokens.primarySoft,
              borderRadius: BorderRadius.circular(tokens.radiusSmall),
            ),
            alignment: Alignment.center,
            child: Text(
              'primarySoft fill',
              style: theme.textTheme.bodySmall?.copyWith(color: cs.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// Private helpers

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 10),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: context.brandTokens.muted,
          letterSpacing: 1,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final hex = color
        .toARGB32()
        .toRadixString(16)
        .toUpperCase()
        .padLeft(8, '0');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: context.brandTokens.line2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Text(
            '#$hex',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.brandTokens.muted,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalityChip extends StatelessWidget {
  const _ModalityChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(
            context.brandTokens.radiusSmall,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
