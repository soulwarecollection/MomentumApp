enum GoalType {
  fatLoss,
  weightGain,
  strengthPr
  ;

  String get label => switch (this) {
    fatLoss => 'Fat loss',
    weightGain => 'Weight gain',
    strengthPr => 'Strength PR',
  };

  String get description => switch (this) {
    fatLoss => 'Lose body weight by a target date',
    weightGain => 'Gain body weight by a target date',
    strengthPr => 'Hit a new 1RM on a specific lift',
  };
}
