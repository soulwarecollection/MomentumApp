import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/features/paywall/domain/entities/pro_package.dart';
import 'package:momentum/features/paywall/domain/repositories/purchases_gateway.dart';
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart';
import 'package:momentum/features/paywall/presentation/cubits/paywall_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/fake_purchases_gateway.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;
  late FakePurchasesGateway gateway;
  late EntitlementCubit entitlement;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    gateway = FakePurchasesGateway();
    entitlement = EntitlementCubit(gateway, prefs);
  });

  tearDown(() async {
    await entitlement.close();
  });

  test('uses fallback prices when RevenueCat has no API key', () async {
    gateway.configureResult = false;
    await entitlement.initialize();
    final cubit = PaywallCubit(gateway, entitlement);

    await cubit.load();

    expect(cubit.state.packages, hasLength(3));
    expect(cubit.state.storeConfigured, isFalse);
    expect(gateway.packageCalls, 0);
    await cubit.close();
  });

  test('loads the monthly, annual, and lifetime offering packages', () async {
    gateway.packages = _purchasablePackages();
    await entitlement.initialize();
    final cubit = PaywallCubit(gateway, entitlement);

    await cubit.load();

    expect(cubit.state.packages.every((item) => item.isPurchasable), isTrue);
    expect(cubit.state.selectedPlan, ProPlan.annual);
    await cubit.close();
  });

  test('successful purchase activates Pro', () async {
    gateway.packages = _purchasablePackages();
    await entitlement.initialize();
    final cubit = PaywallCubit(gateway, entitlement);
    await cubit.load();

    await cubit.purchaseSelected();

    expect(gateway.purchaseCalls, 1);
    expect(cubit.state.status, PaywallStatus.success);
    expect(entitlement.state.isPro, isTrue);
    await cubit.close();
  });

  test('cancelled purchase returns to ready without unlocking', () async {
    gateway
      ..packages = _purchasablePackages()
      ..purchaseResult = ProPurchaseResult.cancelled;
    await entitlement.initialize();
    final cubit = PaywallCubit(gateway, entitlement);
    await cubit.load();

    await cubit.purchaseSelected();

    expect(cubit.state.status, PaywallStatus.ready);
    expect(entitlement.state.isPro, isFalse);
    await cubit.close();
  });
}

List<ProPackage> _purchasablePackages() => ProPackage.fallback
    .map(
      (package) => ProPackage(
        identifier: package.identifier,
        plan: package.plan,
        price: package.price,
        storePackage: Object(),
      ),
    )
    .toList(growable: false);
