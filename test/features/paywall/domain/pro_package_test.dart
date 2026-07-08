import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/features/paywall/domain/entities/pro_package.dart';

void main() {
  group('ProPackage.perMonthEquivalent', () {
    test('computes a per-month price for the annual plan', () {
      const package = ProPackage(
        identifier: 'annual',
        plan: ProPlan.annual,
        price: r'$23.99',
      );

      expect(package.perMonthEquivalent, r'$2.00/mo');
    });

    test('is null for the monthly plan', () {
      const package = ProPackage(
        identifier: 'monthly',
        plan: ProPlan.monthly,
        price: r'$3.49',
      );

      expect(package.perMonthEquivalent, isNull);
    });

    test('is null for the lifetime plan', () {
      const package = ProPackage(
        identifier: 'lifetime',
        plan: ProPlan.lifetime,
        price: r'$59.99',
      );

      expect(package.perMonthEquivalent, isNull);
    });

    test('is null when the price string has no parsable number', () {
      const package = ProPackage(
        identifier: 'annual',
        plan: ProPlan.annual,
        price: 'Free trial',
      );

      expect(package.perMonthEquivalent, isNull);
    });
  });
}
