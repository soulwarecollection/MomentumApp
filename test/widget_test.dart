import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/core/theme/theme_cubit.dart';
import 'package:momentum/features/goals/data/repositories/goal_repository_impl.dart';
import 'package:momentum/features/goals/domain/repositories/goal_repository.dart';
import 'package:momentum/features/goals/presentation/cubit/goal_cubit.dart';
import 'package:momentum/features/library/data/repositories/library_repository_impl.dart';
import 'package:momentum/features/library/domain/repositories/library_repository.dart';
import 'package:momentum/features/logging/data/repositories/logging_repository_impl.dart';
import 'package:momentum/features/logging/domain/repositories/logging_repository.dart';
import 'package:momentum/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:momentum/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:momentum/features/paywall/domain/repositories/purchases_gateway.dart';
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart';
import 'package:momentum/features/paywall/presentation/cubits/paywall_cubit.dart';
import 'package:momentum/features/progress/data/repositories/progress_repository_impl.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';
import 'package:momentum/features/progress/presentation/cubits/history_cubit.dart';
import 'package:momentum/features/progress/presentation/cubits/progress_cubit.dart';
import 'package:momentum/features/progress/presentation/cubits/session_detail_cubit.dart';
import 'package:momentum/features/routines/data/repositories/routines_repository_impl.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/routines/domain/usecases/day_usecases.dart';
import 'package:momentum/features/routines/domain/usecases/exercise_usecases.dart';
import 'package:momentum/features/routines/domain/usecases/plan_usecases.dart';
import 'package:momentum/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:momentum/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:momentum/features/sync/domain/entities/token_pair.dart';
import 'package:momentum/features/sync/domain/repositories/account_repository.dart';
import 'package:momentum/features/sync/presentation/cubits/account_cubit.dart';
import 'package:momentum/features/sync/presentation/cubits/sync_status_cubit.dart';
import 'package:momentum/features/weight/data/repositories/weight_repository_impl.dart';
import 'package:momentum/features/weight/domain/repositories/weight_repository.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_cubit.dart';
import 'package:momentum/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fake_purchases_gateway.dart';

class _FakeAccountRepository implements AccountRepository {
  @override
  Future<Either<Failure, TokenPair>> signIn(
    String email,
    String password,
  ) async => left(const NetworkFailure(message: 'not implemented'));

  @override
  Future<Either<Failure, TokenPair>> register(
    String email,
    String password,
  ) async => left(const NetworkFailure(message: 'not implemented'));

  @override
  Future<void> signOut() async {}

  @override
  Future<bool> get isSignedIn async => false;

  @override
  Future<String?> get accountEmail async => null;
}

void main() {
  late AppDatabase testDb;
  late ThemeCubit themeCubit;
  late EntitlementCubit entitlementCubit;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    testDb = AppDatabase(NativeDatabase.memory());
    themeCubit = ThemeCubit(prefs);
    final purchasesGateway = FakePurchasesGateway()..configureResult = false;
    entitlementCubit = EntitlementCubit(purchasesGateway, prefs);
    await entitlementCubit.initialize();

    await getIt.reset();

    // In-memory repository instances shared across factory registrations.
    final routinesRepo = RoutinesRepositoryImpl(testDb);
    final loggingRepo = LoggingRepositoryImpl(testDb);
    final progressRepo = ProgressRepositoryImpl(testDb);
    final scheduleRepo = ScheduleRepositoryImpl(prefs);

    getIt
      ..registerSingleton<SharedPreferences>(prefs)
      ..registerSingleton<AppDatabase>(testDb)
      ..registerSingleton<ThemeCubit>(themeCubit)
      ..registerSingleton<PurchasesGateway>(purchasesGateway)
      ..registerSingleton<EntitlementCubit>(entitlementCubit)
      ..registerLazySingleton<RoutinesRepository>(() => routinesRepo)
      ..registerLazySingleton<LoggingRepository>(() => loggingRepo)
      ..registerLazySingleton<ProgressRepository>(() => progressRepo)
      ..registerLazySingleton<ScheduleRepository>(() => scheduleRepo)
      ..registerLazySingleton<LibraryRepository>(
        () => LibraryRepositoryImpl(testDb),
      )
      ..registerFactory<AddDayUseCase>(
        () => AddDayUseCase(routinesRepo),
      )
      ..registerFactory<EditDayUseCase>(
        () => EditDayUseCase(routinesRepo),
      )
      ..registerFactory<DeleteDayUseCase>(
        () => DeleteDayUseCase(routinesRepo),
      )
      ..registerFactory<ReorderDaysUseCase>(
        () => ReorderDaysUseCase(routinesRepo),
      )
      ..registerFactory<AddExerciseUseCase>(
        () => AddExerciseUseCase(routinesRepo),
      )
      ..registerFactory<EditExerciseUseCase>(
        () => EditExerciseUseCase(routinesRepo),
      )
      ..registerFactory<DeleteExerciseUseCase>(
        () => DeleteExerciseUseCase(routinesRepo),
      )
      ..registerFactory<ReorderExercisesUseCase>(
        () => ReorderExercisesUseCase(routinesRepo),
      )
      ..registerFactory<WatchPlansUseCase>(
        () => WatchPlansUseCase(routinesRepo),
      )
      ..registerFactory<CreatePlanUseCase>(
        () => CreatePlanUseCase(routinesRepo),
      )
      ..registerFactory<DuplicatePlanUseCase>(
        () => DuplicatePlanUseCase(routinesRepo),
      )
      ..registerFactory<DeletePlanUseCase>(
        () => DeletePlanUseCase(routinesRepo),
      )
      ..registerFactory<SetActivePlanUseCase>(
        () => SetActivePlanUseCase(routinesRepo),
      )
      ..registerFactory<RenamePlanUseCase>(
        () => RenamePlanUseCase(routinesRepo),
      )
      ..registerFactory<HistoryCubit>(
        () => HistoryCubit(progressRepo),
      )
      ..registerFactory<ProgressCubit>(
        () => ProgressCubit(progressRepo),
      )
      ..registerFactory<SessionDetailCubit>(
        () => SessionDetailCubit(progressRepo),
      )
      ..registerFactory<PaywallCubit>(
        () => PaywallCubit(purchasesGateway, entitlementCubit),
      )
      ..registerLazySingleton<AccountCubit>(
        () => AccountCubit(_FakeAccountRepository()),
      )
      ..registerLazySingleton<SyncStatusCubit>(SyncStatusCubit.new)
      ..registerLazySingleton<WeightRepository>(
        () => WeightRepositoryImpl(testDb),
      )
      ..registerSingleton<WeightCubit>(
        WeightCubit(WeightRepositoryImpl(testDb))..init(),
      )
      ..registerLazySingleton<GoalRepository>(
        () => GoalRepositoryImpl(testDb),
      )
      ..registerSingleton<GoalCubit>(
        GoalCubit(
          GoalRepositoryImpl(testDb),
          WeightRepositoryImpl(testDb),
          loggingRepo,
        ),
      )
      ..registerLazySingleton<OnboardingRepository>(
        () => OnboardingRepositoryImpl(prefs),
      );

    // Widget tests exercise the app as a returning user — onboarding
    // already complete — so the router's redirect doesn't intercept them.
    await getIt<OnboardingRepository>().completeOnboarding(
      justOnboarded: false,
    );
  });

  tearDownAll(() async {
    if (getIt.isRegistered<AccountCubit>()) {
      await getIt<AccountCubit>().close();
    }
    if (getIt.isRegistered<SyncStatusCubit>()) {
      await getIt<SyncStatusCubit>().close();
    }
    await entitlementCubit.close();
    await themeCubit.close();
    await testDb.close();
    await getIt.reset();
  });

  testWidgets('App renders bottom navigation', (tester) async {
    await tester.pumpWidget(const MomentumApp());
    await tester.pump();
    expect(find.byType(BottomAppBar), findsOneWidget);
    // Explicitly unmount before teardown so Drift stream-close timers
    // fire within FakeAsync scope rather than after it ends.
    await tester.pumpWidget(const SizedBox.shrink());
    // Advance FakeAsync time so zero-duration timers from stream teardown fire.
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump();
  });
}
