import 'package:momentum/features/progress/domain/enums/date_range.dart';

enum ProFeature {
  unlimitedPlans,
  advancedAnalytics,
  volumeBalance,
  cloudSync,
  wearable
  ;

  String get title => switch (this) {
    ProFeature.unlimitedPlans => 'Unlimited plans',
    ProFeature.advancedAnalytics => 'Long-range analytics',
    ProFeature.volumeBalance => 'Volume balance',
    ProFeature.cloudSync => 'Cloud sync & backup',
    ProFeature.wearable => 'Watch logging',
  };

  String get description => switch (this) {
    ProFeature.unlimitedPlans =>
      'Build as many training rotations as you need.',
    ProFeature.advancedAnalytics =>
      'See six-month and all-time performance trends.',
    ProFeature.volumeBalance =>
      'Understand where your weekly training volume goes.',
    ProFeature.cloudSync =>
      'Keep your private workout data backed up across devices.',
    ProFeature.wearable => 'Log workouts from Apple Watch and Wear OS.',
  };
}

abstract final class ProAccessPolicy {
  static const freePlanLimit = 4;

  static bool canCreatePlan({
    required bool isPro,
    required int currentPlanCount,
  }) => isPro || currentPlanCount < freePlanLimit;

  static bool canUseDateRange({
    required bool isPro,
    required DateRange range,
  }) => isPro || !range.isPro;

  static bool canUseFeature({
    required bool isPro,
    required ProFeature feature,
  }) => isPro;
}
