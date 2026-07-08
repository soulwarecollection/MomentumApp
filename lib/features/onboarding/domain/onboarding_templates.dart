import 'package:momentum/core/db/seed_exercises.dart';
import 'package:momentum/core/enums/equipment_type.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/onboarding/domain/entities/onboarding_focus.dart';

class OnboardingExercise {
  const OnboardingExercise({required this.name, this.equipment});

  final String name;
  final String? equipment;
}

class OnboardingDayTemplate {
  const OnboardingDayTemplate({required this.label, required this.exercises});

  final String label;
  final List<OnboardingExercise> exercises;
}

const List<String> _push = ['Chest', 'Shoulders', 'Triceps'];
const List<String> _pull = ['Back', 'Biceps', 'Rear Delts'];
const List<String> _legs = ['Legs', 'Quads', 'Hamstrings', 'Glutes', 'Calves'];
const List<String> _upper = [..._push, ..._pull];
const List<String> _fullBody = [..._push, ..._pull, ..._legs];

/// Day labels + the muscle-group buckets (matching [kExerciseSeeds]'
/// `muscleGroup` field) each day draws exercises from.
const Map<int, List<(String, List<String>)>> _strengthSplits = {
  3: [
    ('Full Body A', _fullBody),
    ('Full Body B', _fullBody),
    ('Full Body C', _fullBody),
  ],
  4: [
    ('Upper', _upper),
    ('Lower', _legs),
    ('Upper', _upper),
    ('Lower', _legs),
  ],
  5: [
    ('Push', _push),
    ('Pull', _pull),
    ('Legs', _legs),
    ('Push', _push),
    ('Pull', _pull),
  ],
  6: [
    ('Push', _push),
    ('Pull', _pull),
    ('Legs', _legs),
    ('Push', _push),
    ('Pull', _pull),
    ('Legs', _legs),
  ],
};

const _cardioTemplate = [
  ('Easy Run', ['Running']),
  ('Intervals', ['Running', 'Cycling', 'Jump Rope']),
  ('Long Run', ['Running', 'Cycling', 'Swimming']),
];

const _exercisesPerDay = 3;
const _defaultSplitDays = 4;

String? _normalizeEquipment(String? raw) {
  if (raw == null) return null;
  final key = raw.toLowerCase().replaceAll(' ', '');
  for (final type in EquipmentType.values) {
    if (type.name == key) return type.name;
  }
  return null;
}

/// Builds a starter plan template for the onboarding wizard's "confirm" step,
/// pulling real exercise names from the app's seeded catalog
/// ([kExerciseSeeds]) instead of inventing placeholder data.
List<OnboardingDayTemplate> buildOnboardingPlan({
  required OnboardingFocus focus,
  required int splitDays,
}) {
  if (focus == OnboardingFocus.cardio) {
    return [
      for (final (label, names) in _cardioTemplate)
        OnboardingDayTemplate(
          label: label,
          exercises: [
            for (final name in names) OnboardingExercise(name: name),
          ],
        ),
    ];
  }

  final modality = focus == OnboardingFocus.strength
      ? Modality.strength
      : Modality.bodyweight;
  final split =
      _strengthSplits[splitDays] ?? _strengthSplits[_defaultSplitDays]!;
  final used = <String>{};
  final days = <OnboardingDayTemplate>[];

  for (final (label, muscleGroups) in split) {
    final picks = <OnboardingExercise>[];
    for (final (name, seedModality, muscleGroup, equipment) in kExerciseSeeds) {
      if (picks.length >= _exercisesPerDay) break;
      if (seedModality != modality) continue;
      if (muscleGroup == null || !muscleGroups.contains(muscleGroup)) {
        continue;
      }
      if (!used.add(name)) continue;
      picks.add(
        OnboardingExercise(
          name: name,
          equipment: _normalizeEquipment(equipment),
        ),
      );
    }
    days.add(OnboardingDayTemplate(label: label, exercises: picks));
  }

  return days;
}
