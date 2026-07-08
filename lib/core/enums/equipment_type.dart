enum EquipmentType {
  barbell,
  dumbbell,
  cable,
  machine,
  bodyweight,
  kettlebell,
  other
  ;

  String get label => switch (this) {
    barbell => 'Barbell',
    dumbbell => 'Dumbbell',
    cable => 'Cable',
    machine => 'Machine',
    bodyweight => 'Bodyweight',
    kettlebell => 'Kettlebell',
    other => 'Other',
  };

  String get shortLabel => switch (this) {
    barbell => 'Barbell',
    dumbbell => 'Dumbbell',
    cable => 'Cable',
    machine => 'Machine',
    bodyweight => 'Bodyweight',
    kettlebell => 'Kettlebell',
    other => 'Other',
  };
}
