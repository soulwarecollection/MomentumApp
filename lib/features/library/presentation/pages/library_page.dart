import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/features/library/domain/entities/exercise.dart';
import 'package:momentum/features/library/presentation/cubits/library_cubit.dart';
import 'package:momentum/features/library/presentation/cubits/library_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LibraryCubit>()..load(),
      child: const _LibraryView(),
    );
  }
}

class _LibraryView extends StatelessWidget {
  const _LibraryView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Browse',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: tokens.muted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATALOG',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: tokens.faint,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.4,
                    ),
                  ),
                  Text(
                    'Exercises',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.55,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: SearchBar(
              hintText: 'Search exercises…',
              leading: const Icon(
                PhosphorIconsRegular.magnifyingGlass,
                size: 20,
              ),
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(
                theme.colorScheme.surface,
              ),
              side: WidgetStatePropertyAll(BorderSide(color: tokens.line)),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              constraints: const BoxConstraints(minHeight: 46),
              onChanged: context.read<LibraryCubit>().setQuery,
            ),
          ),
          const _ModalityChips(),
          Expanded(
            child: BlocBuilder<LibraryCubit, LibraryState>(
              builder: (context, state) => switch (state) {
                LibraryLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                LibraryError(:final message) => Center(child: Text(message)),
                LibraryReady(:final exercises) =>
                  exercises.isEmpty
                      ? const _EmptyView()
                      : _ExerciseList(exercises: exercises),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalityChips extends StatelessWidget {
  const _ModalityChips();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, state) {
        final selected = state is LibraryReady ? state.selectedModality : null;
        final cubit = context.read<LibraryCubit>();
        return SizedBox(
          height: 52,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            children: [
              FilterChip(
                label: const Text('All'),
                selected: selected == null,
                onSelected: (_) => cubit.setModality(null),
              ),
              ...Modality.values.map(
                (m) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterChip(
                    label: Text(m.label),
                    selected: selected == m,
                    onSelected: (_) =>
                        cubit.setModality(selected == m ? null : m),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    return Center(
      child: Text(
        'No exercises found.',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: tokens.muted),
      ),
    );
  }
}

class _ExerciseList extends StatelessWidget {
  const _ExerciseList({required this.exercises});

  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 40),
      itemCount: exercises.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, i) => _ExerciseTile(exercise: exercises[i]),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  const _ExerciseTile({required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<BrandTokens>()!;
    final theme = Theme.of(context);
    final color = _modalityColor(tokens, exercise.modality);
    final subtitle = [
      if (exercise.equipment != null) exercise.equipment!,
      if (exercise.muscleGroup != null) exercise.muscleGroup!,
    ].join(' · ');

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(tokens.radiusCard),
      child: InkWell(
        onTap: () => context.push('/library/exercise', extra: exercise),
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: tokens.line),
            borderRadius: BorderRadius.circular(tokens.radiusCard),
            boxShadow: tokens.cardShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 9,
                height: 34,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle.isNotEmpty)
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
                size: 20,
                color: tokens.faint,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _modalityColor(BrandTokens t, Modality m) => switch (m) {
    Modality.strength => t.push,
    Modality.bodyweight => t.legs,
    Modality.cardio => t.cardio,
    Modality.timed => t.pull,
  };
}
