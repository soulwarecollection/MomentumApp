/// The movement pattern / equipment category of a workout exercise.
///
/// Stored in SQLite as TEXT via `textEnum`; the column value equals
/// the variant name (e.g. `"strength"`).
///
/// Metric keys per modality — the `metrics` map always contains at
/// least the required keys; optional keys may be absent.
///
/// ```dart
/// // strength:   {weight, reps}
/// //             optional: {extraReps, halfReps, rpe}
/// // bodyweight: {reps}
/// //             optional: {extraReps, assistKg}
/// // cardio:     {distanceKm, timeMin}
/// //             optional: {avgHeartRate, paceMinKm}
/// // timed:      {timeMin}
/// //             optional: {rounds}
/// ```
enum Modality {
  /// Free-weight or machine lifts (bench press, squat, deadlift…).
  strength,

  /// Calisthenics where the primary load is body weight.
  bodyweight,

  /// Sustained-effort exercises (run, cycle, row, swim…).
  cardio,

  /// Duration-based work (plank, EMOM, AMRAP rounds…).
  timed
  ;

  String get label => switch (this) {
    Modality.strength => 'Strength',
    Modality.bodyweight => 'Bodyweight',
    Modality.cardio => 'Cardio',
    Modality.timed => 'Timed',
  };
}
