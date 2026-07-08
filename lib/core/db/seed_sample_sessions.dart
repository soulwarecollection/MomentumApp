import 'package:drift/drift.dart' show Value;
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/enums/modality.dart';

/// Creates a "Push / Pull / Legs" plan (active, 6 logged sessions) and a
/// "Full Body" plan (structure only) to demonstrate the free 4-plan limit.
///
/// Returns `true` if data was seeded, `false` if a plan already exists.
Future<bool> seedSampleSessions(AppDatabase db) async {
  final existing =
      await (db.select(db.plans)
            ..where((t) => t.deletedAt.isNull())
            ..limit(1))
          .getSingleOrNull();
  if (existing != null) return false;

  final now = DateTime.now();

  // ── Create the plan ─────────────────────────────────────────────────
  final planId = await db.plansDao.insertPlan(
    PlansCompanion.insert(
      name: 'Push / Pull / Legs',
      createdAt: now,
      updatedAt: now,
    ),
  );

  // ── Create plan days ────────────────────────────────────────────────
  final pushDayId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: planId,
      orderIndex: 0,
      focus: const Value('Push'),
    ),
  );
  final pullDayId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: planId,
      orderIndex: 1,
      focus: const Value('Pull'),
    ),
  );
  final legsDayId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: planId,
      orderIndex: 2,
      focus: const Value('Legs'),
    ),
  );

  // ── Exercises per day ───────────────────────────────────────────────
  for (final (i, name, equipment, sets, scheme) in [
    (0, 'Bench Press', 'Barbell', 4, '4×8'),
    (1, 'Overhead Press', 'Barbell', 3, '3×8'),
    (2, 'Lateral Raise', 'Dumbbell', 3, '3×15'),
    (3, 'Tricep Pushdown', 'Cable', 3, '3×12'),
  ]) {
    await db.plansDao.insertPlanExercise(
      PlanExercisesCompanion.insert(
        planDayId: pushDayId,
        orderIndex: i,
        name: name,
        equipment: Value(equipment),
        targetSets: Value(sets),
        scheme: Value(scheme),
      ),
    );
  }

  for (final (i, name, equipment, sets, scheme) in [
    (0, 'Deadlift', 'Barbell', 3, '3×5'),
    (1, 'Barbell Row', 'Barbell', 4, '4×8'),
    (2, 'Lat Pulldown', 'Cable', 3, '3×10'),
    (3, 'Dumbbell Curl', 'Dumbbell', 3, '3×12'),
  ]) {
    await db.plansDao.insertPlanExercise(
      PlanExercisesCompanion.insert(
        planDayId: pullDayId,
        orderIndex: i,
        name: name,
        equipment: Value(equipment),
        targetSets: Value(sets),
        scheme: Value(scheme),
      ),
    );
  }

  for (final (i, name, equipment, sets, scheme) in [
    (0, 'Squat', 'Barbell', 4, '4×6'),
    (1, 'Romanian Deadlift', 'Barbell', 3, '3×8'),
    (2, 'Leg Press', 'Machine', 3, '3×12'),
    (3, 'Calf Raise', 'Machine', 4, '4×15'),
  ]) {
    await db.plansDao.insertPlanExercise(
      PlanExercisesCompanion.insert(
        planDayId: legsDayId,
        orderIndex: i,
        name: name,
        equipment: Value(equipment),
        targetSets: Value(sets),
        scheme: Value(scheme),
      ),
    );
  }

  // ── Log 6 sessions (2 full PPL rotations) ──────────────────────────
  final sessions = [
    // Rotation 1
    const _Session(
      daysAgo: 13,
      focus: 'Push',
      dayIndex: 0,
      exercises: [
        _Exs('Bench Press', Modality.strength, [
          {'weight': 60.0, 'reps': 8},
          {'weight': 70.0, 'reps': 8},
          {'weight': 75.0, 'reps': 7},
          {'weight': 75.0, 'reps': 6},
        ]),
        _Exs('Overhead Press', Modality.strength, [
          {'weight': 40.0, 'reps': 8},
          {'weight': 45.0, 'reps': 8},
          {'weight': 47.5, 'reps': 7},
        ]),
        _Exs('Lateral Raise', Modality.strength, [
          {'weight': 10.0, 'reps': 15},
          {'weight': 10.0, 'reps': 15},
          {'weight': 12.0, 'reps': 12},
        ]),
        _Exs('Tricep Pushdown', Modality.strength, [
          {'weight': 22.5, 'reps': 12},
          {'weight': 25.0, 'reps': 12},
          {'weight': 25.0, 'reps': 10},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 11,
      focus: 'Pull',
      dayIndex: 1,
      exercises: [
        _Exs('Deadlift', Modality.strength, [
          {'weight': 80.0, 'reps': 5},
          {'weight': 100.0, 'reps': 5},
          {'weight': 110.0, 'reps': 4},
        ]),
        _Exs('Barbell Row', Modality.strength, [
          {'weight': 60.0, 'reps': 8},
          {'weight': 65.0, 'reps': 8},
          {'weight': 67.5, 'reps': 7},
          {'weight': 67.5, 'reps': 6},
        ]),
        _Exs('Lat Pulldown', Modality.strength, [
          {'weight': 50.0, 'reps': 10},
          {'weight': 55.0, 'reps': 10},
          {'weight': 57.5, 'reps': 9},
        ]),
        _Exs('Dumbbell Curl', Modality.strength, [
          {'weight': 12.0, 'reps': 12},
          {'weight': 14.0, 'reps': 12},
          {'weight': 14.0, 'reps': 10},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 9,
      focus: 'Legs',
      dayIndex: 2,
      exercises: [
        _Exs('Squat', Modality.strength, [
          {'weight': 70.0, 'reps': 6},
          {'weight': 80.0, 'reps': 6},
          {'weight': 85.0, 'reps': 5},
          {'weight': 85.0, 'reps': 5},
        ]),
        _Exs('Romanian Deadlift', Modality.strength, [
          {'weight': 60.0, 'reps': 8},
          {'weight': 65.0, 'reps': 8},
          {'weight': 67.5, 'reps': 7},
        ]),
        _Exs('Leg Press', Modality.strength, [
          {'weight': 120.0, 'reps': 12},
          {'weight': 130.0, 'reps': 12},
          {'weight': 140.0, 'reps': 10},
        ]),
        _Exs('Calf Raise', Modality.strength, [
          {'weight': 50.0, 'reps': 15},
          {'weight': 50.0, 'reps': 15},
          {'weight': 55.0, 'reps': 12},
          {'weight': 55.0, 'reps': 12},
        ]),
      ],
    ),
    // Rotation 2 — slightly heavier
    const _Session(
      daysAgo: 6,
      focus: 'Push',
      dayIndex: 0,
      exercises: [
        _Exs('Bench Press', Modality.strength, [
          {'weight': 65.0, 'reps': 8},
          {'weight': 72.5, 'reps': 8},
          {'weight': 77.5, 'reps': 7},
          {'weight': 77.5, 'reps': 6},
        ]),
        _Exs('Overhead Press', Modality.strength, [
          {'weight': 42.5, 'reps': 8},
          {'weight': 47.5, 'reps': 8},
          {'weight': 50.0, 'reps': 6},
        ]),
        _Exs('Lateral Raise', Modality.strength, [
          {'weight': 10.0, 'reps': 15},
          {'weight': 12.0, 'reps': 15},
          {'weight': 12.0, 'reps': 13},
        ]),
        _Exs('Tricep Pushdown', Modality.strength, [
          {'weight': 25.0, 'reps': 12},
          {'weight': 27.5, 'reps': 12},
          {'weight': 27.5, 'reps': 10},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 4,
      focus: 'Pull',
      dayIndex: 1,
      exercises: [
        _Exs('Deadlift', Modality.strength, [
          {'weight': 90.0, 'reps': 5},
          {'weight': 105.0, 'reps': 5},
          {'weight': 115.0, 'reps': 3},
        ]),
        _Exs('Barbell Row', Modality.strength, [
          {'weight': 62.5, 'reps': 8},
          {'weight': 67.5, 'reps': 8},
          {'weight': 70.0, 'reps': 7},
          {'weight': 70.0, 'reps': 6},
        ]),
        _Exs('Lat Pulldown', Modality.strength, [
          {'weight': 55.0, 'reps': 10},
          {'weight': 57.5, 'reps': 10},
          {'weight': 60.0, 'reps': 8},
        ]),
        _Exs('Dumbbell Curl', Modality.strength, [
          {'weight': 14.0, 'reps': 12},
          {'weight': 14.0, 'reps': 12},
          {'weight': 16.0, 'reps': 9},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 2,
      focus: 'Legs',
      dayIndex: 2,
      exercises: [
        _Exs('Squat', Modality.strength, [
          {'weight': 75.0, 'reps': 6},
          {'weight': 85.0, 'reps': 6},
          {'weight': 90.0, 'reps': 5},
          {'weight': 90.0, 'reps': 4},
        ]),
        _Exs('Romanian Deadlift', Modality.strength, [
          {'weight': 62.5, 'reps': 8},
          {'weight': 67.5, 'reps': 8},
          {'weight': 70.0, 'reps': 7},
        ]),
        _Exs('Leg Press', Modality.strength, [
          {'weight': 130.0, 'reps': 12},
          {'weight': 140.0, 'reps': 12},
          {'weight': 150.0, 'reps': 10},
        ]),
        _Exs('Calf Raise', Modality.strength, [
          {'weight': 52.5, 'reps': 15},
          {'weight': 55.0, 'reps': 15},
          {'weight': 57.5, 'reps': 12},
          {'weight': 57.5, 'reps': 12},
        ]),
      ],
    ),
  ];

  for (final s in sessions) {
    final start = now.subtract(Duration(days: s.daysAgo));
    final end = start.add(const Duration(minutes: 60));

    final sessionId = await db.sessionsDao.insertSession(
      SessionsCompanion.insert(
        startedAt: start,
        endedAt: Value(end),
        durationSeconds: const Value(3600),
        focus: Value(s.focus),
        planId: Value(planId),
        dayIndex: Value(s.dayIndex),
        updatedAt: now,
      ),
    );

    for (var i = 0; i < s.exercises.length; i++) {
      final ex = s.exercises[i];
      final exId = await db.sessionsDao.insertSessionExercise(
        SessionExercisesCompanion.insert(
          sessionId: sessionId,
          orderIndex: i,
          name: ex.name,
          modality: ex.modality,
        ),
      );

      for (var j = 0; j < ex.sets.length; j++) {
        await db.loggedSetsDao.insertLoggedSet(
          LoggedSetsCompanion.insert(
            sessionExerciseId: exId,
            orderIndex: j,
            modality: ex.modality,
            metrics: ex.sets[j],
            isDone: const Value(true),
            createdAt: start.add(Duration(minutes: 5 + j * 4)),
          ),
        );
      }
    }
  }

  // After 6 sessions (2 full PPL rotations) cursor wraps to day 0 (Push).
  // The plan's default currentDayIndex is already 0, so just activate it.
  await db.plansDao.setActivePlan(planId);

  // ── Plan 2: Full Body (structure only — demonstrates free 4-plan limit) ──
  final fbId = await db.plansDao.insertPlan(
    PlansCompanion.insert(
      name: 'Full Body',
      createdAt: now,
      updatedAt: now,
    ),
  );
  final fbAId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: fbId,
      orderIndex: 0,
      focus: const Value('Full Body A'),
    ),
  );
  final fbBId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: fbId,
      orderIndex: 1,
      focus: const Value('Full Body B'),
    ),
  );
  final fbCId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: fbId,
      orderIndex: 2,
      focus: const Value('Full Body C'),
    ),
  );

  for (final (i, name, eq, sets, scheme) in [
    (0, 'Squat', 'Barbell', 4, '4×6'),
    (1, 'Bench Press', 'Barbell', 4, '4×8'),
    (2, 'Barbell Row', 'Barbell', 3, '3×8'),
    (3, 'Plank', 'Bodyweight', 3, '3×60s'),
  ]) {
    await db.plansDao.insertPlanExercise(
      PlanExercisesCompanion.insert(
        planDayId: fbAId,
        orderIndex: i,
        name: name,
        equipment: Value(eq),
        targetSets: Value(sets),
        scheme: Value(scheme),
      ),
    );
  }
  for (final (i, name, eq, sets, scheme) in [
    (0, 'Deadlift', 'Barbell', 3, '3×5'),
    (1, 'Overhead Press', 'Barbell', 3, '3×8'),
    (2, 'Pull-Up', 'Bodyweight', 3, '3×max'),
    (3, 'Dip', 'Bodyweight', 3, '3×max'),
  ]) {
    await db.plansDao.insertPlanExercise(
      PlanExercisesCompanion.insert(
        planDayId: fbBId,
        orderIndex: i,
        name: name,
        equipment: Value(eq),
        targetSets: Value(sets),
        scheme: Value(scheme),
      ),
    );
  }
  for (final (i, name, eq, sets, scheme) in [
    (0, 'Front Squat', 'Barbell', 3, '3×6'),
    (1, 'Incline DB Press', 'Dumbbell', 3, '3×10'),
    (2, 'Cable Row', 'Cable', 3, '3×10'),
    (3, 'Lat Pulldown', 'Cable', 3, '3×10'),
  ]) {
    await db.plansDao.insertPlanExercise(
      PlanExercisesCompanion.insert(
        planDayId: fbCId,
        orderIndex: i,
        name: name,
        equipment: Value(eq),
        targetSets: Value(sets),
        scheme: Value(scheme),
      ),
    );
  }

  return true;
}

/// Seeds two extra plans (Upper/Lower + Cardio Endurance) with 14 sessions
/// spanning 3–6 weeks ago. These are plans 3 and 4 in the pro demo (plans 1
/// and 2 come from seedSampleSessions). Returns true if anything was added;
/// false if Upper/Lower already exists (guards against double-seeding).
Future<bool> seedProExtras(AppDatabase db) async {
  final activePlans = await (db.select(
    db.plans,
  )..where((t) => t.deletedAt.isNull())).get();
  if (activePlans.any((p) => p.name == 'Upper / Lower')) return false;

  final now = DateTime.now();

  // ── Plan 2: Upper / Lower ─────────────────────────────────────────────────
  final ulId = await db.plansDao.insertPlan(
    PlansCompanion.insert(
      name: 'Upper / Lower',
      createdAt: now,
      updatedAt: now,
    ),
  );
  final ulUpperAId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: ulId,
      orderIndex: 0,
      focus: const Value('Upper A'),
    ),
  );
  final ulLowerAId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: ulId,
      orderIndex: 1,
      focus: const Value('Lower A'),
    ),
  );
  final ulUpperBId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: ulId,
      orderIndex: 2,
      focus: const Value('Upper B'),
    ),
  );
  final ulLowerBId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: ulId,
      orderIndex: 3,
      focus: const Value('Lower B'),
    ),
  );

  for (final (i, name, eq, sets, scheme) in [
    (0, 'Bench Press', 'Barbell', 4, '4×8'),
    (1, 'Barbell Row', 'Barbell', 4, '4×8'),
    (2, 'Overhead Press', 'Barbell', 3, '3×8'),
    (3, 'Lat Pulldown', 'Cable', 3, '3×10'),
    (4, 'Tricep Pushdown', 'Cable', 3, '3×12'),
    (5, 'Dumbbell Curl', 'Dumbbell', 3, '3×12'),
  ]) {
    await db.plansDao.insertPlanExercise(
      PlanExercisesCompanion.insert(
        planDayId: ulUpperAId,
        orderIndex: i,
        name: name,
        equipment: Value(eq),
        targetSets: Value(sets),
        scheme: Value(scheme),
      ),
    );
  }
  for (final (i, name, eq, sets, scheme) in [
    (0, 'Squat', 'Barbell', 4, '4×6'),
    (1, 'Romanian Deadlift', 'Barbell', 3, '3×8'),
    (2, 'Leg Press', 'Machine', 3, '3×12'),
    (3, 'Hip Thrust', 'Barbell', 3, '3×10'),
    (4, 'Calf Raise', 'Machine', 4, '4×15'),
  ]) {
    await db.plansDao.insertPlanExercise(
      PlanExercisesCompanion.insert(
        planDayId: ulLowerAId,
        orderIndex: i,
        name: name,
        equipment: Value(eq),
        targetSets: Value(sets),
        scheme: Value(scheme),
      ),
    );
  }
  for (final (i, name, eq, sets, scheme) in [
    (0, 'Incline DB Press', 'Dumbbell', 3, '3×10'),
    (1, 'Cable Row', 'Cable', 4, '4×10'),
    (2, 'DB Shoulder Press', 'Dumbbell', 3, '3×10'),
    (3, 'Pull-Up', 'Bodyweight', 3, '3×max'),
    (4, 'Skull Crusher', 'EZ Bar', 3, '3×12'),
    (5, 'Hammer Curl', 'Dumbbell', 3, '3×12'),
  ]) {
    await db.plansDao.insertPlanExercise(
      PlanExercisesCompanion.insert(
        planDayId: ulUpperBId,
        orderIndex: i,
        name: name,
        equipment: Value(eq),
        targetSets: Value(sets),
        scheme: Value(scheme),
      ),
    );
  }
  for (final (i, name, eq, sets, scheme) in [
    (0, 'Front Squat', 'Barbell', 3, '3×6'),
    (1, 'Leg Curl', 'Machine', 3, '3×12'),
    (2, 'Bulgarian Split Squat', 'Dumbbell', 3, '3×8'),
    (3, 'Leg Extension', 'Machine', 3, '3×15'),
    (4, 'Seated Calf Raise', 'Machine', 3, '3×15'),
  ]) {
    await db.plansDao.insertPlanExercise(
      PlanExercisesCompanion.insert(
        planDayId: ulLowerBId,
        orderIndex: i,
        name: name,
        equipment: Value(eq),
        targetSets: Value(sets),
        scheme: Value(scheme),
      ),
    );
  }

  // ── Plan 3: Cardio Endurance ──────────────────────────────────────────────
  final cardioId = await db.plansDao.insertPlan(
    PlansCompanion.insert(
      name: 'Cardio Endurance',
      createdAt: now,
      updatedAt: now,
    ),
  );
  final cardioRunId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: cardioId,
      orderIndex: 0,
      focus: const Value('Run'),
    ),
  );
  final cardioCycleId = await db.plansDao.insertPlanDay(
    PlanDaysCompanion.insert(
      planId: cardioId,
      orderIndex: 1,
      focus: const Value('Cycle'),
    ),
  );
  await db.plansDao.insertPlanExercise(
    PlanExercisesCompanion.insert(
      planDayId: cardioRunId,
      orderIndex: 0,
      name: 'Running',
      targetSets: const Value(1),
      scheme: const Value('5 km'),
    ),
  );
  await db.plansDao.insertPlanExercise(
    PlanExercisesCompanion.insert(
      planDayId: cardioCycleId,
      orderIndex: 0,
      name: 'Cycling',
      targetSets: const Value(1),
      scheme: const Value('20 km'),
    ),
  );

  // ── Upper / Lower sessions (8 sessions — 2 rotations, 3–6 weeks ago) ─────
  final ulSessions = [
    const _Session(
      daysAgo: 38,
      focus: 'Upper A',
      dayIndex: 0,
      exercises: [
        _Exs('Bench Press', Modality.strength, [
          {'weight': 80.0, 'reps': 8},
          {'weight': 85.0, 'reps': 8},
          {'weight': 87.5, 'reps': 7},
          {'weight': 87.5, 'reps': 6},
        ]),
        _Exs('Barbell Row', Modality.strength, [
          {'weight': 70.0, 'reps': 8},
          {'weight': 75.0, 'reps': 8},
          {'weight': 77.5, 'reps': 7},
          {'weight': 77.5, 'reps': 6},
        ]),
        _Exs('Overhead Press', Modality.strength, [
          {'weight': 50.0, 'reps': 8},
          {'weight': 52.5, 'reps': 8},
          {'weight': 55.0, 'reps': 6},
        ]),
        _Exs('Lat Pulldown', Modality.strength, [
          {'weight': 57.5, 'reps': 10},
          {'weight': 60.0, 'reps': 10},
          {'weight': 62.5, 'reps': 8},
        ]),
        _Exs('Tricep Pushdown', Modality.strength, [
          {'weight': 27.5, 'reps': 12},
          {'weight': 30.0, 'reps': 12},
          {'weight': 30.0, 'reps': 10},
        ]),
        _Exs('Dumbbell Curl', Modality.strength, [
          {'weight': 15.0, 'reps': 12},
          {'weight': 16.0, 'reps': 12},
          {'weight': 16.0, 'reps': 10},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 36,
      focus: 'Lower A',
      dayIndex: 1,
      exercises: [
        _Exs('Squat', Modality.strength, [
          {'weight': 90.0, 'reps': 6},
          {'weight': 100.0, 'reps': 6},
          {'weight': 105.0, 'reps': 5},
          {'weight': 105.0, 'reps': 5},
        ]),
        _Exs('Romanian Deadlift', Modality.strength, [
          {'weight': 70.0, 'reps': 8},
          {'weight': 75.0, 'reps': 8},
          {'weight': 77.5, 'reps': 7},
        ]),
        _Exs('Leg Press', Modality.strength, [
          {'weight': 140.0, 'reps': 12},
          {'weight': 150.0, 'reps': 12},
          {'weight': 160.0, 'reps': 10},
        ]),
        _Exs('Hip Thrust', Modality.strength, [
          {'weight': 80.0, 'reps': 10},
          {'weight': 90.0, 'reps': 10},
          {'weight': 90.0, 'reps': 8},
        ]),
        _Exs('Calf Raise', Modality.strength, [
          {'weight': 55.0, 'reps': 15},
          {'weight': 60.0, 'reps': 15},
          {'weight': 60.0, 'reps': 12},
          {'weight': 60.0, 'reps': 12},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 34,
      focus: 'Upper B',
      dayIndex: 2,
      exercises: [
        _Exs('Incline DB Press', Modality.strength, [
          {'weight': 27.5, 'reps': 10},
          {'weight': 30.0, 'reps': 10},
          {'weight': 32.5, 'reps': 8},
        ]),
        _Exs('Cable Row', Modality.strength, [
          {'weight': 55.0, 'reps': 10},
          {'weight': 60.0, 'reps': 10},
          {'weight': 62.5, 'reps': 9},
          {'weight': 62.5, 'reps': 8},
        ]),
        _Exs('DB Shoulder Press', Modality.strength, [
          {'weight': 22.5, 'reps': 10},
          {'weight': 25.0, 'reps': 10},
          {'weight': 25.0, 'reps': 8},
        ]),
        _Exs('Pull-Up', Modality.bodyweight, [
          {'reps': 8.0},
          {'reps': 7.0},
          {'reps': 6.0},
        ]),
        _Exs('Skull Crusher', Modality.strength, [
          {'weight': 30.0, 'reps': 12},
          {'weight': 32.5, 'reps': 12},
          {'weight': 32.5, 'reps': 10},
        ]),
        _Exs('Hammer Curl', Modality.strength, [
          {'weight': 15.0, 'reps': 12},
          {'weight': 17.5, 'reps': 12},
          {'weight': 17.5, 'reps': 10},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 32,
      focus: 'Lower B',
      dayIndex: 3,
      exercises: [
        _Exs('Front Squat', Modality.strength, [
          {'weight': 60.0, 'reps': 6},
          {'weight': 65.0, 'reps': 6},
          {'weight': 67.5, 'reps': 5},
        ]),
        _Exs('Leg Curl', Modality.strength, [
          {'weight': 42.5, 'reps': 12},
          {'weight': 45.0, 'reps': 12},
          {'weight': 47.5, 'reps': 10},
        ]),
        _Exs('Bulgarian Split Squat', Modality.strength, [
          {'weight': 25.0, 'reps': 8},
          {'weight': 27.5, 'reps': 8},
          {'weight': 27.5, 'reps': 7},
        ]),
        _Exs('Leg Extension', Modality.strength, [
          {'weight': 47.5, 'reps': 15},
          {'weight': 50.0, 'reps': 15},
          {'weight': 52.5, 'reps': 12},
        ]),
        _Exs('Seated Calf Raise', Modality.strength, [
          {'weight': 30.0, 'reps': 15},
          {'weight': 32.5, 'reps': 15},
          {'weight': 35.0, 'reps': 12},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 29,
      focus: 'Upper A',
      dayIndex: 0,
      exercises: [
        _Exs('Bench Press', Modality.strength, [
          {'weight': 82.5, 'reps': 8},
          {'weight': 87.5, 'reps': 8},
          {'weight': 90.0, 'reps': 7},
          {'weight': 90.0, 'reps': 5},
        ]),
        _Exs('Barbell Row', Modality.strength, [
          {'weight': 72.5, 'reps': 8},
          {'weight': 77.5, 'reps': 8},
          {'weight': 80.0, 'reps': 7},
          {'weight': 80.0, 'reps': 6},
        ]),
        _Exs('Overhead Press', Modality.strength, [
          {'weight': 52.5, 'reps': 8},
          {'weight': 55.0, 'reps': 8},
          {'weight': 57.5, 'reps': 6},
        ]),
        _Exs('Lat Pulldown', Modality.strength, [
          {'weight': 60.0, 'reps': 10},
          {'weight': 62.5, 'reps': 10},
          {'weight': 65.0, 'reps': 8},
        ]),
        _Exs('Tricep Pushdown', Modality.strength, [
          {'weight': 30.0, 'reps': 12},
          {'weight': 32.5, 'reps': 12},
          {'weight': 32.5, 'reps': 10},
        ]),
        _Exs('Dumbbell Curl', Modality.strength, [
          {'weight': 16.0, 'reps': 12},
          {'weight': 17.5, 'reps': 11},
          {'weight': 17.5, 'reps': 10},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 27,
      focus: 'Lower A',
      dayIndex: 1,
      exercises: [
        _Exs('Squat', Modality.strength, [
          {'weight': 92.5, 'reps': 6},
          {'weight': 102.5, 'reps': 6},
          {'weight': 107.5, 'reps': 5},
          {'weight': 107.5, 'reps': 4},
        ]),
        _Exs('Romanian Deadlift', Modality.strength, [
          {'weight': 72.5, 'reps': 8},
          {'weight': 77.5, 'reps': 8},
          {'weight': 80.0, 'reps': 7},
        ]),
        _Exs('Leg Press', Modality.strength, [
          {'weight': 145.0, 'reps': 12},
          {'weight': 155.0, 'reps': 12},
          {'weight': 165.0, 'reps': 10},
        ]),
        _Exs('Hip Thrust', Modality.strength, [
          {'weight': 85.0, 'reps': 10},
          {'weight': 92.5, 'reps': 10},
          {'weight': 92.5, 'reps': 8},
        ]),
        _Exs('Calf Raise', Modality.strength, [
          {'weight': 57.5, 'reps': 15},
          {'weight': 62.5, 'reps': 15},
          {'weight': 62.5, 'reps': 12},
          {'weight': 62.5, 'reps': 12},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 25,
      focus: 'Upper B',
      dayIndex: 2,
      exercises: [
        _Exs('Incline DB Press', Modality.strength, [
          {'weight': 30.0, 'reps': 10},
          {'weight': 32.5, 'reps': 10},
          {'weight': 35.0, 'reps': 8},
        ]),
        _Exs('Cable Row', Modality.strength, [
          {'weight': 57.5, 'reps': 10},
          {'weight': 62.5, 'reps': 10},
          {'weight': 65.0, 'reps': 9},
          {'weight': 65.0, 'reps': 7},
        ]),
        _Exs('DB Shoulder Press', Modality.strength, [
          {'weight': 25.0, 'reps': 10},
          {'weight': 27.5, 'reps': 10},
          {'weight': 27.5, 'reps': 8},
        ]),
        _Exs('Pull-Up', Modality.bodyweight, [
          {'reps': 9.0},
          {'reps': 8.0},
          {'reps': 7.0},
        ]),
        _Exs('Skull Crusher', Modality.strength, [
          {'weight': 32.5, 'reps': 12},
          {'weight': 35.0, 'reps': 12},
          {'weight': 35.0, 'reps': 10},
        ]),
        _Exs('Hammer Curl', Modality.strength, [
          {'weight': 17.5, 'reps': 12},
          {'weight': 18.0, 'reps': 11},
          {'weight': 18.0, 'reps': 10},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 23,
      focus: 'Lower B',
      dayIndex: 3,
      exercises: [
        _Exs('Front Squat', Modality.strength, [
          {'weight': 62.5, 'reps': 6},
          {'weight': 67.5, 'reps': 6},
          {'weight': 70.0, 'reps': 5},
        ]),
        _Exs('Leg Curl', Modality.strength, [
          {'weight': 45.0, 'reps': 12},
          {'weight': 47.5, 'reps': 12},
          {'weight': 50.0, 'reps': 10},
        ]),
        _Exs('Bulgarian Split Squat', Modality.strength, [
          {'weight': 27.5, 'reps': 8},
          {'weight': 30.0, 'reps': 8},
          {'weight': 30.0, 'reps': 7},
        ]),
        _Exs('Leg Extension', Modality.strength, [
          {'weight': 50.0, 'reps': 15},
          {'weight': 52.5, 'reps': 15},
          {'weight': 55.0, 'reps': 12},
        ]),
        _Exs('Seated Calf Raise', Modality.strength, [
          {'weight': 32.5, 'reps': 15},
          {'weight': 35.0, 'reps': 15},
          {'weight': 37.5, 'reps': 12},
        ]),
      ],
    ),
  ];

  for (final s in ulSessions) {
    final start = now.subtract(Duration(days: s.daysAgo));
    final end = start.add(const Duration(minutes: 75));
    final sessionId = await db.sessionsDao.insertSession(
      SessionsCompanion.insert(
        startedAt: start,
        endedAt: Value(end),
        durationSeconds: const Value(4500),
        focus: Value(s.focus),
        planId: Value(ulId),
        dayIndex: Value(s.dayIndex),
        updatedAt: now,
      ),
    );
    for (var i = 0; i < s.exercises.length; i++) {
      final ex = s.exercises[i];
      final exId = await db.sessionsDao.insertSessionExercise(
        SessionExercisesCompanion.insert(
          sessionId: sessionId,
          orderIndex: i,
          name: ex.name,
          modality: ex.modality,
        ),
      );
      for (var j = 0; j < ex.sets.length; j++) {
        await db.loggedSetsDao.insertLoggedSet(
          LoggedSetsCompanion.insert(
            sessionExerciseId: exId,
            orderIndex: j,
            modality: ex.modality,
            metrics: ex.sets[j],
            isDone: const Value(true),
            createdAt: start.add(Duration(minutes: 5 + j * 4)),
          ),
        );
      }
    }
  }

  // ── Cardio sessions (6 sessions — 3 runs + 3 cycles, 4–6 weeks ago) ───────
  final cardioSessions = [
    const _Session(
      daysAgo: 44,
      focus: 'Run',
      dayIndex: 0,
      exercises: [
        _Exs('Running', Modality.cardio, [
          {'distanceKm': 5.0, 'timeMin': 28.0},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 42,
      focus: 'Cycle',
      dayIndex: 1,
      exercises: [
        _Exs('Cycling', Modality.cardio, [
          {'distanceKm': 18.0, 'timeMin': 42.0},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 37,
      focus: 'Run',
      dayIndex: 0,
      exercises: [
        _Exs('Running', Modality.cardio, [
          {'distanceKm': 5.5, 'timeMin': 30.0},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 35,
      focus: 'Cycle',
      dayIndex: 1,
      exercises: [
        _Exs('Cycling', Modality.cardio, [
          {'distanceKm': 22.0, 'timeMin': 48.0},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 30,
      focus: 'Run',
      dayIndex: 0,
      exercises: [
        _Exs('Running', Modality.cardio, [
          {'distanceKm': 6.0, 'timeMin': 32.0},
        ]),
      ],
    ),
    const _Session(
      daysAgo: 28,
      focus: 'Cycle',
      dayIndex: 1,
      exercises: [
        _Exs('Cycling', Modality.cardio, [
          {'distanceKm': 25.0, 'timeMin': 54.0},
        ]),
      ],
    ),
  ];

  for (final s in cardioSessions) {
    final start = now.subtract(Duration(days: s.daysAgo));
    final durationMin = s.exercises.first.sets.first['timeMin']!.toInt();
    final sessionId = await db.sessionsDao.insertSession(
      SessionsCompanion.insert(
        startedAt: start,
        endedAt: Value(start.add(Duration(minutes: durationMin))),
        durationSeconds: Value(durationMin * 60),
        focus: Value(s.focus),
        planId: Value(cardioId),
        dayIndex: Value(s.dayIndex),
        updatedAt: now,
      ),
    );
    final ex = s.exercises.first;
    final exId = await db.sessionsDao.insertSessionExercise(
      SessionExercisesCompanion.insert(
        sessionId: sessionId,
        orderIndex: 0,
        name: ex.name,
        modality: ex.modality,
      ),
    );
    await db.loggedSetsDao.insertLoggedSet(
      LoggedSetsCompanion.insert(
        sessionExerciseId: exId,
        orderIndex: 0,
        modality: ex.modality,
        metrics: ex.sets.first,
        isDone: const Value(true),
        createdAt: start.add(const Duration(minutes: 1)),
      ),
    );
  }

  return true;
}

class _Session {
  const _Session({
    required this.daysAgo,
    required this.focus,
    required this.dayIndex,
    required this.exercises,
  });

  final int daysAgo;
  final String focus;
  final int dayIndex;
  final List<_Exs> exercises;
}

class _Exs {
  const _Exs(this.name, this.modality, this.sets);

  final String name;
  final Modality modality;
  final List<Map<String, double>> sets;
}
