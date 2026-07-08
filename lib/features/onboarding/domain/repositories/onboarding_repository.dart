abstract class OnboardingRepository {
  bool hasCompletedOnboarding();

  Future<void> completeOnboarding({required bool justOnboarded});

  bool isJustOnboarded();

  Future<void> clearJustOnboarded();
}
