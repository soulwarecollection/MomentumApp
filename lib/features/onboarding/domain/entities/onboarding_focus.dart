import 'package:momentum/core/enums/modality.dart';

/// The training focus a new user picks during onboarding — a simplified,
/// wizard-friendly axis distinct from [Modality] (which classifies individual
/// exercises, not a whole plan).
enum OnboardingFocus {
  strength,
  bodyweight,
  cardio
  ;

  String get label => switch (this) {
    OnboardingFocus.strength => 'Strength',
    OnboardingFocus.bodyweight => 'Bodyweight',
    OnboardingFocus.cardio => 'Cardio',
  };

  String get description => switch (this) {
    OnboardingFocus.strength => 'Barbell and machine lifts',
    OnboardingFocus.bodyweight => 'Calisthenics, no equipment needed',
    OnboardingFocus.cardio => 'Running, cycling, rowing',
  };
}
