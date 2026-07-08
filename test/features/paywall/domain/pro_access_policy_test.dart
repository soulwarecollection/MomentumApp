import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/features/paywall/domain/pro_access_policy.dart';
import 'package:momentum/features/progress/domain/enums/date_range.dart';

void main() {
  group('ProAccessPolicy', () {
    test('free users can create up to four plans', () {
      expect(
        ProAccessPolicy.canCreatePlan(
          isPro: false,
          currentPlanCount: 3,
        ),
        isTrue,
      );
      expect(
        ProAccessPolicy.canCreatePlan(
          isPro: false,
          currentPlanCount: 4,
        ),
        isFalse,
      );
    });

    test('Pro users can create plans beyond the free limit', () {
      expect(
        ProAccessPolicy.canCreatePlan(
          isPro: true,
          currentPlanCount: 30,
        ),
        isTrue,
      );
    });

    test('six-month and one-year ranges require Pro', () {
      expect(
        ProAccessPolicy.canUseDateRange(
          isPro: false,
          range: DateRange.oneMonth,
        ),
        isTrue,
      );
      expect(
        ProAccessPolicy.canUseDateRange(
          isPro: false,
          range: DateRange.sixMonths,
        ),
        isFalse,
      );
      expect(
        ProAccessPolicy.canUseDateRange(
          isPro: false,
          range: DateRange.oneYear,
        ),
        isFalse,
      );
      expect(
        ProAccessPolicy.canUseDateRange(
          isPro: true,
          range: DateRange.oneYear,
        ),
        isTrue,
      );
    });

    test('all declared Pro features unlock with entitlement', () {
      for (final feature in ProFeature.values) {
        expect(
          ProAccessPolicy.canUseFeature(isPro: false, feature: feature),
          isFalse,
        );
        expect(
          ProAccessPolicy.canUseFeature(isPro: true, feature: feature),
          isTrue,
        );
      }
    });
  });
}
