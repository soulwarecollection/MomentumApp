// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:momentum/core/db/app_database.dart' as _i743;
import 'package:momentum/core/di/app_module.dart' as _i798;
import 'package:momentum/core/theme/theme_cubit.dart' as _i548;
import 'package:momentum/features/goals/data/repositories/goal_repository_impl.dart'
    as _i424;
import 'package:momentum/features/goals/domain/repositories/goal_repository.dart'
    as _i724;
import 'package:momentum/features/goals/presentation/cubit/goal_cubit.dart'
    as _i883;
import 'package:momentum/features/library/data/repositories/library_repository_impl.dart'
    as _i1044;
import 'package:momentum/features/library/domain/repositories/library_repository.dart'
    as _i178;
import 'package:momentum/features/library/presentation/cubits/library_cubit.dart'
    as _i17;
import 'package:momentum/features/logging/data/repositories/logging_repository_impl.dart'
    as _i562;
import 'package:momentum/features/logging/domain/repositories/logging_repository.dart'
    as _i499;
import 'package:momentum/features/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i257;
import 'package:momentum/features/onboarding/domain/repositories/onboarding_repository.dart'
    as _i801;
import 'package:momentum/features/onboarding/presentation/cubits/onboarding_cubit.dart'
    as _i908;
import 'package:momentum/features/paywall/data/revenue_cat_purchases_gateway.dart'
    as _i758;
import 'package:momentum/features/paywall/domain/repositories/purchases_gateway.dart'
    as _i389;
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart'
    as _i149;
import 'package:momentum/features/paywall/presentation/cubits/paywall_cubit.dart'
    as _i644;
import 'package:momentum/features/progress/data/repositories/progress_repository_impl.dart'
    as _i711;
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart'
    as _i1016;
import 'package:momentum/features/progress/presentation/cubits/history_cubit.dart'
    as _i661;
import 'package:momentum/features/progress/presentation/cubits/progress_cubit.dart'
    as _i618;
import 'package:momentum/features/progress/presentation/cubits/session_detail_cubit.dart'
    as _i279;
import 'package:momentum/features/routines/data/repositories/routines_repository_impl.dart'
    as _i865;
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart'
    as _i56;
import 'package:momentum/features/routines/domain/usecases/day_usecases.dart'
    as _i116;
import 'package:momentum/features/routines/domain/usecases/exercise_usecases.dart'
    as _i301;
import 'package:momentum/features/routines/domain/usecases/plan_usecases.dart'
    as _i982;
import 'package:momentum/features/schedule/data/repositories/schedule_repository_impl.dart'
    as _i444;
import 'package:momentum/features/schedule/domain/repositories/schedule_repository.dart'
    as _i674;
import 'package:momentum/features/weight/data/repositories/weight_repository_impl.dart'
    as _i884;
import 'package:momentum/features/weight/domain/repositories/weight_repository.dart'
    as _i311;
import 'package:momentum/features/weight/presentation/cubit/weight_cubit.dart'
    as _i376;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i743.AppDatabase>(() => appModule.database);
    gh.lazySingleton<_i56.RoutinesRepository>(
      () => _i865.RoutinesRepositoryImpl(gh<_i743.AppDatabase>()),
    );
    gh.lazySingleton<_i311.WeightRepository>(
      () => _i884.WeightRepositoryImpl(gh<_i743.AppDatabase>()),
    );
    gh.factory<_i116.AddDayUseCase>(
      () => _i116.AddDayUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i116.EditDayUseCase>(
      () => _i116.EditDayUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i116.DeleteDayUseCase>(
      () => _i116.DeleteDayUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i116.ReorderDaysUseCase>(
      () => _i116.ReorderDaysUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i301.AddExerciseUseCase>(
      () => _i301.AddExerciseUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i301.EditExerciseUseCase>(
      () => _i301.EditExerciseUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i301.DeleteExerciseUseCase>(
      () => _i301.DeleteExerciseUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i301.ReorderExercisesUseCase>(
      () => _i301.ReorderExercisesUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i982.WatchPlansUseCase>(
      () => _i982.WatchPlansUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i982.CreatePlanUseCase>(
      () => _i982.CreatePlanUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i982.DuplicatePlanUseCase>(
      () => _i982.DuplicatePlanUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i982.DeletePlanUseCase>(
      () => _i982.DeletePlanUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i982.SetActivePlanUseCase>(
      () => _i982.SetActivePlanUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.factory<_i982.RenamePlanUseCase>(
      () => _i982.RenamePlanUseCase(gh<_i56.RoutinesRepository>()),
    );
    gh.lazySingleton<_i178.LibraryRepository>(
      () => _i1044.LibraryRepositoryImpl(gh<_i743.AppDatabase>()),
    );
    gh.lazySingleton<_i389.PurchasesGateway>(
      () => _i758.RevenueCatPurchasesGateway(),
    );
    gh.lazySingleton<_i499.LoggingRepository>(
      () => _i562.LoggingRepositoryImpl(gh<_i743.AppDatabase>()),
    );
    gh.lazySingleton<_i1016.ProgressRepository>(
      () => _i711.ProgressRepositoryImpl(gh<_i743.AppDatabase>()),
    );
    gh.lazySingleton<_i724.GoalRepository>(
      () => _i424.GoalRepositoryImpl(gh<_i743.AppDatabase>()),
    );
    gh.factory<_i17.LibraryCubit>(
      () => _i17.LibraryCubit(gh<_i178.LibraryRepository>()),
    );
    gh.singleton<_i149.EntitlementCubit>(
      () => _i149.EntitlementCubit(
        gh<_i389.PurchasesGateway>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.singleton<_i548.ThemeCubit>(
      () => _i548.ThemeCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i674.ScheduleRepository>(
      () => _i444.ScheduleRepositoryImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i661.HistoryCubit>(
      () => _i661.HistoryCubit(gh<_i1016.ProgressRepository>()),
    );
    gh.factory<_i618.ProgressCubit>(
      () => _i618.ProgressCubit(gh<_i1016.ProgressRepository>()),
    );
    gh.factory<_i279.SessionDetailCubit>(
      () => _i279.SessionDetailCubit(gh<_i1016.ProgressRepository>()),
    );
    gh.lazySingleton<_i801.OnboardingRepository>(
      () => _i257.OnboardingRepositoryImpl(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i376.WeightCubit>(
      () => _i376.WeightCubit(gh<_i311.WeightRepository>()),
    );
    gh.factory<_i908.OnboardingCubit>(
      () => _i908.OnboardingCubit(
        gh<_i56.RoutinesRepository>(),
        gh<_i801.OnboardingRepository>(),
      ),
    );
    gh.singleton<_i883.GoalCubit>(
      () => _i883.GoalCubit(
        gh<_i724.GoalRepository>(),
        gh<_i311.WeightRepository>(),
        gh<_i499.LoggingRepository>(),
      ),
    );
    gh.factory<_i644.PaywallCubit>(
      () => _i644.PaywallCubit(
        gh<_i389.PurchasesGateway>(),
        gh<_i149.EntitlementCubit>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i798.AppModule {}
