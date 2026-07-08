import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/features/onboarding/domain/entities/onboarding_focus.dart';
import 'package:momentum/features/onboarding/domain/onboarding_templates.dart';

void main() {
  group('buildOnboardingPlan', () {
    test('cardio focus always returns the fixed 3-day template', () {
      final plan = buildOnboardingPlan(
        focus: OnboardingFocus.cardio,
        splitDays: 5,
      );

      expect(plan.map((d) => d.label), [
        'Easy Run',
        'Intervals',
        'Long Run',
      ]);
      for (final day in plan) {
        expect(day.exercises, isNotEmpty);
      }
    });

    for (final splitDays in [3, 4, 5, 6]) {
      test(
        'strength focus with $splitDays days returns $splitDays days '
        'with no exercise repeated across the plan',
        () {
          final plan = buildOnboardingPlan(
            focus: OnboardingFocus.strength,
            splitDays: splitDays,
          );

          expect(plan, hasLength(splitDays));

          final allNames = plan.expand((d) => d.exercises.map((e) => e.name));
          expect(allNames.toSet().length, allNames.length);
        },
      );
    }

    test('bodyweight focus draws from the bodyweight seed pool only', () {
      final plan = buildOnboardingPlan(
        focus: OnboardingFocus.bodyweight,
        splitDays: 3,
      );

      expect(plan, hasLength(3));
      final allNames = plan.expand((d) => d.exercises.map((e) => e.name));
      expect(allNames.toSet().length, allNames.length);
      expect(allNames, isNot(contains('Bench Press')));
    });

    test('falls back to the 4-day split for an unrecognised split length', () {
      final plan = buildOnboardingPlan(
        focus: OnboardingFocus.strength,
        splitDays: 99,
      );

      expect(plan.map((d) => d.label), ['Upper', 'Lower', 'Upper', 'Lower']);
    });
  });
}
