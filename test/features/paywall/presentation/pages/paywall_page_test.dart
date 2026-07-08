import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/theme/app_theme.dart';
import 'package:momentum/features/paywall/domain/pro_access_policy.dart';
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart';
import 'package:momentum/features/paywall/presentation/cubits/paywall_cubit.dart';
import 'package:momentum/features/paywall/presentation/pages/paywall_page.dart';
import 'package:momentum/features/paywall/presentation/widgets/pro_gate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/fake_purchases_gateway.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakePurchasesGateway gateway;
  late EntitlementCubit entitlement;
  late AppDatabase testDb;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    gateway = FakePurchasesGateway()..configureResult = false;
    entitlement = EntitlementCubit(gateway, prefs);
    await entitlement.initialize();
    testDb = AppDatabase(NativeDatabase.memory());
    await getIt.reset();
    getIt
      ..registerFactory<PaywallCubit>(
        () => PaywallCubit(gateway, entitlement),
      )
      ..registerSingleton<AppDatabase>(testDb);
  });

  tearDown(() async {
    await entitlement.close();
    await testDb.close();
    await getIt.reset();
  });

  testWidgets('paywall shows all three product choices', (tester) async {
    await tester.pumpWidget(
      BlocProvider.value(
        value: entitlement,
        child: MaterialApp(
          theme: AppTheme.light,
          home: const PaywallPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Monthly'), findsOneWidget);
    expect(find.text('Annual'), findsOneWidget);
    expect(find.text('Lifetime'), findsOneWidget);
    expect(find.text('Restore purchases'), findsOneWidget);
  });

  testWidgets(
    'paywall shows contextual copy with real session count for '
    'volumeBalance',
    (tester) async {
      await testDb.sessionsDao.insertSession(
        SessionsCompanion.insert(
          // False positive: `startedAt` is a required, default-less
          // parameter on the generated Companion constructor.
          // ignore: avoid_redundant_argument_values
          startedAt: DateTime(2026, 6, 1),
          updatedAt: DateTime(2026, 6, 2),
        ),
      );
      await testDb.sessionsDao.insertSession(
        SessionsCompanion.insert(
          startedAt: DateTime(2026, 6, 3),
          updatedAt: DateTime(2026, 6, 4),
        ),
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: entitlement,
          child: MaterialApp(
            theme: AppTheme.light,
            home: const PaywallPage(feature: ProFeature.volumeBalance),
          ),
        ),
      );
      // The subtitle's session count comes from a real (non-fake-async)
      // Drift stream read, so let it resolve outside the fake test zone.
      await tester.runAsync(
        () => testDb.sessionsDao.watchActiveSessions().first,
      );
      await tester.pumpAndSettle();

      expect(
        find.textContaining("You've logged 2 sessions"),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'paywall falls back to the generic description with no session '
    'history',
    (tester) async {
      await tester.pumpWidget(
        BlocProvider.value(
          value: entitlement,
          child: MaterialApp(
            theme: AppTheme.light,
            home: const PaywallPage(feature: ProFeature.volumeBalance),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(ProFeature.volumeBalance.description),
        findsOneWidget,
      );
    },
  );

  testWidgets('ProGate reacts to the debug entitlement', (tester) async {
    await tester.pumpWidget(
      BlocProvider.value(
        value: entitlement,
        child: MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: ProGate(
              feature: ProFeature.volumeBalance,
              child: Text('Unlocked analytics'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Volume balance'), findsOneWidget);
    expect(find.text('Unlocked analytics'), findsNothing);

    await entitlement.setDebugPro(value: true);
    await tester.pump();

    expect(find.text('Unlocked analytics'), findsOneWidget);
  });

  testWidgets(
    'ProGate with blurLocked renders the real child behind the CTA '
    'instead of hiding it',
    (tester) async {
      await tester.pumpWidget(
        BlocProvider.value(
          value: entitlement,
          child: MaterialApp(
            theme: AppTheme.light,
            home: const Scaffold(
              body: ProGate(
                feature: ProFeature.volumeBalance,
                blurLocked: true,
                child: Text('Real volume chart'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Volume balance'), findsOneWidget);
      expect(find.text('Real volume chart'), findsOneWidget);

      await entitlement.setDebugPro(value: true);
      await tester.pump();

      expect(find.text('Real volume chart'), findsOneWidget);
      expect(find.text('Volume balance'), findsNothing);
    },
  );
}
