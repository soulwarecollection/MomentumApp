import 'package:injectable/injectable.dart';
import 'package:momentum/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;
  static const _completedKey = 'onboarding_completed';
  static const _justOnboardedKey = 'onboarding_just_completed';

  @override
  bool hasCompletedOnboarding() => _prefs.getBool(_completedKey) ?? false;

  @override
  Future<void> completeOnboarding({required bool justOnboarded}) async {
    await _prefs.setBool(_completedKey, true);
    await _prefs.setBool(_justOnboardedKey, justOnboarded);
  }

  @override
  bool isJustOnboarded() => _prefs.getBool(_justOnboardedKey) ?? false;

  @override
  Future<void> clearJustOnboarded() async {
    await _prefs.setBool(_justOnboardedKey, false);
  }
}
