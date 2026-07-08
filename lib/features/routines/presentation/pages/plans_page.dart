import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:go_router/go_router.dart';
import 'package:momentum/core/common/widgets/error_state.dart';
import 'package:momentum/core/common/widgets/skeleton_box.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/paywall/domain/pro_access_policy.dart';
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart';
import 'package:momentum/features/paywall/presentation/widgets/pro_gate.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/routines/presentation/cubits/plans_cubit.dart';
import 'package:momentum/features/routines/presentation/cubits/plans_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlansCubit(repo: getIt<RoutinesRepository>())..init(),
      child: const _PlansView(),
    );
  }
}

class _PlansView extends StatelessWidget {
  const _PlansView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'YOUR PROGRAMS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: context.brandTokens.faint,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.4,
              ),
            ),
            Text(
              'Plans',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.55,
              ),
            ),
            Text(
              'Any split — 3, 4, 5, 6 days, your call.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.brandTokens.muted,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<PlansCubit, PlansState>(
        builder: (context, state) => switch (state) {
          PlansInitial() || PlansLoading() => const SkeletonList(),
          PlansError(:final message) => ErrorStateWidget(message: message),
          PlansLoaded(:final plans) =>
            plans.isEmpty
                ? _EmptyPlans(
                    onNewPlan: () => _showCreateDialog(context, 0),
                  )
                : _PlanList(
                    plans: plans,
                    onNewPlan: () => _showCreateDialog(context, plans.length),
                  ),
        },
      ),
    );
  }

  Future<void> _showCreateDialog(
    BuildContext context,
    int currentPlanCount,
  ) async {
    final entitlement = context.read<EntitlementCubit>().state;
    final canCreate = ProAccessPolicy.canCreatePlan(
      isPro: entitlement.isPro,
      currentPlanCount: currentPlanCount,
    );
    if (!canCreate) {
      final unlocked = await requirePro(
        context,
        feature: ProFeature.unlimitedPlans,
      );
      if (!unlocked || !context.mounted) return;
    }

    final cubit = context.read<PlansCubit>();
    final controller = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New plan'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(hintText: 'e.g. PPL'),
          onSubmitted: (_) => _createAndPop(ctx, cubit, controller.text.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => _createAndPop(ctx, cubit, controller.text.trim()),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    controller.dispose();
  }

  Future<void> _createAndPop(
    BuildContext ctx,
    PlansCubit cubit,
    String name,
  ) async {
    if (name.isEmpty) return;
    Navigator.of(ctx).pop();
    final result = await cubit.createPlan(name);
    result.fold(
      (f) {
        if (!ctx.mounted) return;
        ScaffoldMessenger.of(
          ctx,
        ).showSnackBar(SnackBar(content: Text(f.message)));
      },
      (id) {
        if (!ctx.mounted) return;
        unawaited(ctx.push('/plans/$id/edit'));
      },
    );
  }
}

class _EmptyPlans extends StatelessWidget {
  const _EmptyPlans({required this.onNewPlan});

  final VoidCallback onNewPlan;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 34, 20, 120),
      children: [
        Column(
          children: [
            Icon(
              PhosphorIconsRegular.barbell,
              size: 64,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No plans yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Create your first flexible workout rotation.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        _NewPlanButton(onPressed: onNewPlan),
      ],
    );
  }
}

class _PlanList extends StatelessWidget {
  const _PlanList({required this.plans, required this.onNewPlan});

  final List<Plan> plans;
  final VoidCallback onNewPlan;

  @override
  Widget build(BuildContext context) {
    final isPro = context.watch<EntitlementCubit>().state.isPro;
    final atFreeLimit = !ProAccessPolicy.canCreatePlan(
      isPro: isPro,
      currentPlanCount: plans.length,
    );
    return ReorderableListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      buildDefaultDragHandles: false,
      proxyDecorator: (child, _, animation) => Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: child,
      ),
      onReorder: (oldIndex, newIndex) {
        final idx = newIndex > oldIndex ? newIndex - 1 : newIndex;
        final reordered = [...plans];
        final moved = reordered.removeAt(oldIndex);
        reordered.insert(idx, moved);
        unawaited(
          context.read<PlansCubit>().reorderPlans(
            reordered.map((p) => p.id).toList(),
          ),
        );
      },
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          _NewPlanButton(onPressed: onNewPlan, locked: atFreeLimit),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isPro) ...[
                const _PlanProBadge(),
                const SizedBox(width: 6),
              ],
              Text(
                isPro
                    ? 'Unlimited plans included'
                    : 'Free includes ${ProAccessPolicy.freePlanLimit} plans'
                          ' · ${plans.length} used',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.brandTokens.muted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 104),
        ],
      ),
      itemCount: plans.length,
      itemBuilder: (context, i) {
        return _PlanCard(
          key: ValueKey(plans[i].id),
          plan: plans[i],
          planCount: plans.length,
          index: i,
        );
      },
    );
  }
}

class _NewPlanButton extends StatelessWidget {
  const _NewPlanButton({required this.onPressed, this.locked = false});

  final VoidCallback onPressed;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          locked ? PhosphorIconsRegular.lockSimple : PhosphorIconsRegular.plus,
          size: 18,
        ),
        label: Text(locked ? 'Unlock unlimited plans' : 'New plan'),
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

class _PlanCard extends StatefulWidget {
  const _PlanCard({
    required this.plan,
    required this.planCount,
    required this.index,
    super.key,
  });

  final Plan plan;
  final int planCount;
  final int index;

  @override
  State<_PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<_PlanCard> {
  bool _collapsed = false;

  @override
  Widget build(BuildContext context) {
    return _collapsed ? _buildCollapsed(context) : _buildExpanded(context);
  }

  Widget _buildCollapsed(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
        title: Text(
          widget.plan.name,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: widget.plan.isActive
            ? Text(
                'Active',
                style: TextStyle(
                  color: cs.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(PhosphorIconsRegular.caretDown, size: 20),
              tooltip: 'Expand',
              onPressed: () => setState(() => _collapsed = false),
            ),
            ReorderableDragStartListener(
              index: widget.index,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(PhosphorIconsRegular.dotsSixVertical),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpanded(BuildContext context) {
    final cubit = context.read<PlansCubit>();
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/plans/${widget.plan.id}/edit'),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 8, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      widget.plan.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.plan.isActive) ...[
                    const SizedBox(width: 8),
                    _ActiveBadge(color: cs.primary),
                  ],
                  const Spacer(),
                  IconButton(
                    icon: const Icon(PhosphorIconsRegular.caretUp, size: 20),
                    tooltip: 'Collapse',
                    onPressed: () => setState(() => _collapsed = true),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _PlanActions(
                plan: widget.plan,
                planCount: widget.planCount,
                cubit: cubit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActiveBadge extends StatelessWidget {
  const _ActiveBadge({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        'Active',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PlanActions extends StatelessWidget {
  const _PlanActions({
    required this.plan,
    required this.planCount,
    required this.cubit,
  });

  final Plan plan;
  final int planCount;
  final PlansCubit cubit;

  Future<void> _duplicate(BuildContext context) async {
    final isPro = context.read<EntitlementCubit>().state.isPro;
    if (!ProAccessPolicy.canCreatePlan(
      isPro: isPro,
      currentPlanCount: planCount,
    )) {
      final unlocked = await requirePro(
        context,
        feature: ProFeature.unlimitedPlans,
      );
      if (!unlocked || !context.mounted) return;
    }
    await _run(context, () => cubit.duplicatePlan(plan.id));
  }

  Future<void> _run(
    BuildContext context,
    Future<Either<dynamic, dynamic>> Function() action,
  ) async {
    final result = await action();
    result.fold(
      (f) {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$f')));
      },
      (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final smallStyle = theme.textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w600,
    );
    final btnStyle = OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textStyle: smallStyle,
      side: BorderSide(
        color: theme.colorScheme.outline.withValues(alpha: 0.4),
      ),
    );

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        if (!plan.isActive)
          OutlinedButton(
            style: btnStyle,
            onPressed: () =>
                unawaited(_run(context, () => cubit.setActivePlan(plan.id))),
            child: const Text('Set active'),
          ),
        OutlinedButton(
          style: btnStyle,
          onPressed: () => context.push('/plans/${plan.id}/edit'),
          child: const Text('Edit'),
        ),
        OutlinedButton(
          style: btnStyle,
          onPressed: () => unawaited(_duplicate(context)),
          child: const Text('Duplicate'),
        ),
        OutlinedButton(
          style: btnStyle.copyWith(
            foregroundColor: WidgetStatePropertyAll(
              theme.colorScheme.error,
            ),
            side: WidgetStatePropertyAll(
              BorderSide(
                color: theme.colorScheme.error.withValues(alpha: 0.4),
              ),
            ),
          ),
          onPressed: () =>
              unawaited(_run(context, () => cubit.deletePlan(plan.id))),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

class _PlanProBadge extends StatelessWidget {
  const _PlanProBadge();

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: tokens.accentSoft,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'PRO',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: tokens.accent,
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
