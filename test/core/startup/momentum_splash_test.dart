import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/startup/momentum_splash.dart';

void main() {
  testWidgets('shows the Momentum brand while the app starts', (tester) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      const MaterialApp(home: MomentumSplashScreen()),
    );
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('MOMENTUM'), findsOneWidget);
    expect(find.text('BUILD STRENGTH  ·  KEEP MOVING'), findsOneWidget);
    expect(find.bySemanticsLabel('Momentum logo'), findsOneWidget);
    expect(find.bySemanticsLabel('Starting Momentum'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('shows a calm message if startup fails', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MomentumSplashScreen(startupFailed: true),
      ),
    );
    await tester.pump();

    expect(
      find.text('STARTUP PAUSED · PLEASE REOPEN THE APP'),
      findsOneWidget,
    );
  });
}
