import 'package:momentum/core/enums/modality.dart';

/// (name, modality, muscleGroup, equipment)
typedef ExerciseSeed = (String, Modality, String?, String?);

const List<ExerciseSeed> kExerciseSeeds = [
  // ── Strength ──────────────────────────────────────────────────────
  ('Bench Press', Modality.strength, 'Chest', 'Barbell'),
  ('Incline Bench Press', Modality.strength, 'Chest', 'Barbell'),
  ('Dumbbell Fly', Modality.strength, 'Chest', 'Dumbbell'),
  ('Squat', Modality.strength, 'Legs', 'Barbell'),
  ('Front Squat', Modality.strength, 'Legs', 'Barbell'),
  ('Deadlift', Modality.strength, 'Back', 'Barbell'),
  ('Romanian Deadlift', Modality.strength, 'Hamstrings', 'Barbell'),
  ('Hex Bar Deadlift', Modality.strength, 'Back', 'Hex Bar'),
  ('Overhead Press', Modality.strength, 'Shoulders', 'Barbell'),
  ('Shoulder Press', Modality.strength, 'Shoulders', 'Dumbbell'),
  ('Lateral Raise', Modality.strength, 'Shoulders', 'Dumbbell'),
  ('Face Pull', Modality.strength, 'Rear Delts', 'Cable'),
  ('Barbell Row', Modality.strength, 'Back', 'Barbell'),
  ('Lat Pulldown', Modality.strength, 'Back', 'Cable'),
  ('Cable Row', Modality.strength, 'Back', 'Cable'),
  ('Hip Thrust', Modality.strength, 'Glutes', 'Barbell'),
  ('Leg Press', Modality.strength, 'Legs', 'Machine'),
  ('Leg Curl', Modality.strength, 'Hamstrings', 'Machine'),
  ('Leg Extension', Modality.strength, 'Quads', 'Machine'),
  ('Calf Raise', Modality.strength, 'Calves', 'Machine'),
  ('Dumbbell Curl', Modality.strength, 'Biceps', 'Dumbbell'),
  ('Hammer Curl', Modality.strength, 'Biceps', 'Dumbbell'),
  ('Tricep Pushdown', Modality.strength, 'Triceps', 'Cable'),
  ('Skull Crusher', Modality.strength, 'Triceps', 'Barbell'),

  // ── Bodyweight ────────────────────────────────────────────────────
  ('Push-Up', Modality.bodyweight, 'Chest', null),
  ('Pull-Up', Modality.bodyweight, 'Back', null),
  ('Chin-Up', Modality.bodyweight, 'Back', null),
  ('Dip', Modality.bodyweight, 'Chest', null),
  ('Inverted Row', Modality.bodyweight, 'Back', null),
  ('Pike Push-Up', Modality.bodyweight, 'Shoulders', null),
  ('Bulgarian Split Squat', Modality.bodyweight, 'Legs', null),
  ('Nordic Curl', Modality.bodyweight, 'Hamstrings', null),
  ('Pistol Squat', Modality.bodyweight, 'Legs', null),

  // ── Cardio ────────────────────────────────────────────────────────
  ('Running', Modality.cardio, null, null),
  ('Cycling', Modality.cardio, null, null),
  ('Rowing Machine', Modality.cardio, 'Full Body', null),
  ('Elliptical', Modality.cardio, null, null),
  ('Jump Rope', Modality.cardio, null, null),
  ('Stair Climber', Modality.cardio, 'Legs', null),
  ('Swimming', Modality.cardio, null, null),

  // ── Timed ─────────────────────────────────────────────────────────
  ('Plank', Modality.timed, 'Core', null),
  ('Side Plank', Modality.timed, 'Core', null),
  ('Wall Sit', Modality.timed, 'Legs', null),
  ('Dead Hang', Modality.timed, 'Grip', null),
  ('L-Sit', Modality.timed, 'Core', null),
];
