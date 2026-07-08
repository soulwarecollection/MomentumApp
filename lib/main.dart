import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/notifications/notification_service.dart';
import 'package:momentum/core/router/app_router.dart';
import 'package:momentum/core/startup/momentum_splash.dart';
import 'package:momentum/core/theme/app_theme.dart';
import 'package:momentum/core/theme/theme_cubit.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_cubit.dart';
import 'package:momentum/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/sync/presentation/cubits/account_cubit.dart';
import 'package:momentum/features/sync/presentation/cubits/sync_status_cubit.dart';
import 'package:momentum/features/sync/sync_service.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MomentumBootstrap());
}

Future<void> initializeMomentum() async {
  await configureDependencies();
  await _backfillOnboardingFlagForExistingInstalls();
  final notifications = getIt<NotificationService>();
  await notifications.initialize();
  await notifications.requestPermissions();
  await getIt<EntitlementCubit>().initialize();
  await getIt<AccountCubit>().initialize();
  getIt<WeightCubit>().init();
  getIt<GoalCubit>().init(getIt<NotificationService>());
}

/// Installs that already have plans (earlier builds, demo-seeded data)
/// must never be dropped into the onboarding wizard — only a genuinely
/// fresh install (no plans, flag never set) goes through it.
Future<void> _backfillOnboardingFlagForExistingInstalls() async {
  final onboarding = getIt<OnboardingRepository>();
  if (onboarding.hasCompletedOnboarding()) return;
  final plans = await getIt<RoutinesRepository>().watchPlans().first;
  final hasPlans = plans.fold((_) => false, (list) => list.isNotEmpty);
  if (hasPlans) {
    await onboarding.completeOnboarding(justOnboarded: false);
  }
}

class MomentumBootstrap extends StatefulWidget {
  const MomentumBootstrap({super.key});

  @override
  State<MomentumBootstrap> createState() => _MomentumBootstrapState();
}

class _MomentumBootstrapState extends State<MomentumBootstrap> {
  static const _minimumSplashDuration = Duration(milliseconds: 1100);

  var _isReady = false;
  var _startupFailed = false;

  @override
  void initState() {
    super.initState();
    unawaited(_start());
  }

  Future<void> _start() async {
    try {
      await Future.wait([
        initializeMomentum(),
        Future<void>.delayed(_minimumSplashDuration),
      ]);
      if (mounted) setState(() => _isReady = true);
    } on Object catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'Momentum startup',
        ),
      );
      if (mounted) setState(() => _startupFailed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      reverseDuration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: _isReady
          ? const MomentumApp(key: ValueKey('momentum-app'))
          : MaterialApp(
              key: const ValueKey('momentum-splash'),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: MomentumSplashScreen.background,
              ),
              home: MomentumSplashScreen(startupFailed: _startupFailed),
            ),
    );
  }
}

class MomentumApp extends StatefulWidget {
  const MomentumApp({super.key});

  @override
  State<MomentumApp> createState() => _MomentumAppState();
}

class _MomentumAppState extends State<MomentumApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getIt<SyncService>().syncInBackground();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: getIt<ThemeCubit>()),
        BlocProvider<EntitlementCubit>.value(value: getIt<EntitlementCubit>()),
        BlocProvider<AccountCubit>.value(value: getIt<AccountCubit>()),
        BlocProvider<SyncStatusCubit>.value(
          value: getIt<SyncStatusCubit>(),
        ),
        BlocProvider<WeightCubit>.value(value: getIt<WeightCubit>()),
        BlocProvider<GoalCubit>.value(value: getIt<GoalCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Momentum',
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            themeMode: themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
          );
        },
      ),
    );
  }
}
