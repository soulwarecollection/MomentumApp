import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/core/common/widgets/momentum_logo.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/goals/presentation/pages/goal_setup_page.dart';
import 'package:momentum/features/onboarding/domain/entities/onboarding_focus.dart';
import 'package:momentum/features/onboarding/presentation/cubits/onboarding_cubit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BlocBuilder<OnboardingCubit, OnboardingState>(
          buildWhen: (previous, current) => previous.step != current.step,
          builder: (context, state) => state.step > 0
              ? IconButton(
                  icon: const Icon(PhosphorIconsRegular.arrowLeft),
                  onPressed: () => context.read<OnboardingCubit>().back(),
                )
              : const SizedBox.shrink(),
        ),
        title: Text(
          'Set up Momentum',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) => AnimatedSwitcher(
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : const Duration(milliseconds: 220),
            child: switch (state.step) {
              0 => const _WelcomeStep(key: ValueKey('welcome')),
              1 => const _FocusStep(key: ValueKey('focus')),
              2 => const _SplitStep(key: ValueKey('split')),
              _ => const _ConfirmStep(key: ValueKey('confirm')),
            },
          ),
        ),
      ),
    );
  }
}

// ── Step 0: welcome ──────────────────────────────────────────────────────────

class _WelcomeStep extends StatelessWidget {
  const _WelcomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    return _StepScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MomentumLogo(size: 56),
          const SizedBox(height: 24),
          Text(
            "Let's build your first plan",
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'No account needed. Your workouts stay on this phone, and '
            "you can export them anytime — it's your data.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: tokens.muted,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context.read<OnboardingCubit>().nextStep(),
              child: const Text('Get started'),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step 1: focus ────────────────────────────────────────────────────────────

class _FocusStep extends StatelessWidget {
  const _FocusStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (previous, current) => previous.focus != current.focus,
      builder: (context, state) => _StepScaffold(
        title: 'What are you training?',
        subtitle: 'Pick a focus — you can branch out later.',
        onContinue: cubit.nextStep,
        child: Column(
          children: [
            for (final focus in OnboardingFocus.values)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _SelectableTile(
                  title: focus.label,
                  subtitle: focus.description,
                  selected: state.focus == focus,
                  onTap: () => cubit.selectFocus(focus),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Step 2: split length ─────────────────────────────────────────────────────

class _SplitStep extends StatelessWidget {
  const _SplitStep({super.key});

  static const _options = [3, 4, 5, 6];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (previous, current) => previous.splitDays != current.splitDays,
      builder: (context, state) => _StepScaffold(
        title: 'How many days a week?',
        subtitle: 'Your rotation repeats — no fixed weekday.',
        onContinue: cubit.nextStep,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final days in _options)
              ChoiceChip(
                label: Text('$days days'),
                selected: state.splitDays == days,
                onSelected: (_) => cubit.selectSplitDays(days),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Step 3: confirm ──────────────────────────────────────────────────────────

class _ConfirmStep extends StatefulWidget {
  const _ConfirmStep({super.key});

  @override
  State<_ConfirmStep> createState() => _ConfirmStepState();
}

class _ConfirmStepState extends State<_ConfirmStep> {
  Future<void> _build(BuildContext context) async {
    final cubit = context.read<OnboardingCubit>();
    final planId = await cubit.confirmAndCreatePlan();
    if (planId == null || !context.mounted) return;
    await showGoalSetupSheet(context);
    if (context.mounted) context.go('/today');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final days = state.preview;
        return _StepScaffold(
          title: 'Your plan',
          subtitle:
              '${days.length}-day ${state.focus.label.toLowerCase()} '
              'rotation, ready to go — tweak it anytime in Plans.',
          onContinue: state.isSaving ? null : () => unawaited(_build(context)),
          continueLabel: 'Build my plan',
          isBusy: state.isSaving,
          child: Column(
            children: [
              for (final day in days)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(tokens.radiusCard),
                    border: Border.all(color: tokens.line),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day.label,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        day.exercises.isEmpty
                            ? 'Add exercises later in Plans'
                            : day.exercises.map((e) => e.name).join(' · '),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              if (state.error != null) ...[
                const SizedBox(height: 4),
                Text(
                  state.error!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

// ── Shared step scaffold ─────────────────────────────────────────────────────

class _StepScaffold extends StatelessWidget {
  const _StepScaffold({
    required this.child,
    this.title,
    this.subtitle,
    this.onContinue,
    this.continueLabel = 'Continue',
    this.isBusy = false,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final VoidCallback? onContinue;
  final String continueLabel;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: tokens.muted,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                child,
              ],
            ),
          ),
          if (onContinue != null || isBusy)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onContinue,
                child: isBusy
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(continueLabel),
              ),
            ),
        ],
      ),
    );
  }
}

class _SelectableTile extends StatelessWidget {
  const _SelectableTile({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? tokens.primarySoft : theme.colorScheme.surface,
          border: Border.all(
            color: selected ? theme.colorScheme.primary : tokens.line,
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(tokens.radiusCard),
        ),
        child: Row(
          children: [
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
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tokens.muted,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(
                PhosphorIconsFill.checkCircle,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
