import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/fake_purchases_gateway.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;
  late FakePurchasesGateway gateway;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    gateway = FakePurchasesGateway();
  });

  test('initializes as free when RevenueCat is not configured', () async {
    gateway.configureResult = false;
    final cubit = EntitlementCubit(gateway, prefs);

    await cubit.initialize();

    expect(cubit.state.isLoading, isFalse);
    expect(cubit.state.isPro, isFalse);
    expect(cubit.state.isRevenueCatConfigured, isFalse);
    await cubit.close();
  });

  test('reads active Pro entitlement and listens for updates', () async {
    gateway.isPro = true;
    final cubit = EntitlementCubit(gateway, prefs);
    await cubit.initialize();
    expect(cubit.state.isPro, isTrue);

    gateway.setPro(isPro: false);
    expect(cubit.state.isPro, isFalse);
    await cubit.close();
  });

  test('debug override unlocks Pro and persists locally', () async {
    gateway.configureResult = false;
    final cubit = EntitlementCubit(gateway, prefs);
    await cubit.initialize();

    await cubit.setDebugPro(value: true);

    expect(cubit.state.isPro, isTrue);
    expect(cubit.state.isDebugOverride, isTrue);
    expect(prefs.getBool('debug_pro_override'), isTrue);
    await cubit.close();
  });

  test('Pro testing switch is available in debug and test builds', () {
    expect(EntitlementCubit.buildAllowsProTesting, isTrue);
  });
}
