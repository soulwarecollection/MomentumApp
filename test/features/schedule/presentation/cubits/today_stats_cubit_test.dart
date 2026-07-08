import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:momentum/features/schedule/presentation/cubits/today_stats_cubit.dart';

class MockSessionsDao extends Mock implements SessionsDao {}

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late MockSessionsDao dao;
  late MockOnboardingRepository onboardingRepo;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day, 9);
  final yesterday = today.subtract(const Duration(days: 1));
  final twoDaysAgo = today.subtract(const Duration(days: 2));

  SessionRow sessionAt(int id, DateTime startedAt) => SessionRow(
    id: id,
    startedAt: startedAt,
    updatedAt: startedAt,
  );

  setUp(() {
    dao = MockSessionsDao();
    onboardingRepo = MockOnboardingRepository();
    when(() => onboardingRepo.isJustOnboarded()).thenReturn(false);
    when(() => onboardingRepo.clearJustOnboarded()).thenAnswer((_) async {});
  });

  TodayStatsCubit buildCubit() =>
      TodayStatsCubit(dao: dao, onboardingRepo: onboardingRepo);

  group('TodayStatsCubit streakAtRisk', () {
    blocTest<TodayStatsCubit, TodayStatsState>(
      'is true when the streak is alive but nothing was logged today',
      setUp: () {
        when(
          () => dao.watchRecentSessions(limit: any(named: 'limit')),
        ).thenAnswer(
          (_) => Stream.value([
            sessionAt(1, yesterday),
            sessionAt(2, twoDaysAgo),
          ]),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.init(),
      verify: (cubit) {
        expect(cubit.state.streak, 2);
        expect(cubit.state.streakAtRisk, isTrue);
      },
    );

    blocTest<TodayStatsCubit, TodayStatsState>(
      'is false once a session has already been logged today',
      setUp: () {
        when(
          () => dao.watchRecentSessions(limit: any(named: 'limit')),
        ).thenAnswer(
          (_) => Stream.value([
            sessionAt(1, today),
            sessionAt(2, yesterday),
          ]),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.init(),
      verify: (cubit) {
        expect(cubit.state.streak, 2);
        expect(cubit.state.streakAtRisk, isFalse);
      },
    );

    blocTest<TodayStatsCubit, TodayStatsState>(
      'is false when there is no active streak',
      setUp: () {
        when(
          () => dao.watchRecentSessions(limit: any(named: 'limit')),
        ).thenAnswer((_) => Stream.value([sessionAt(1, twoDaysAgo)]));
      },
      build: buildCubit,
      act: (cubit) => cubit.init(),
      verify: (cubit) {
        expect(cubit.state.streak, 0);
        expect(cubit.state.streakAtRisk, isFalse);
      },
    );
  });

  group('TodayStatsCubit justOnboarded', () {
    blocTest<TodayStatsCubit, TodayStatsState>(
      'surfaces the onboarding flag when there are no sessions yet',
      setUp: () {
        when(() => onboardingRepo.isJustOnboarded()).thenReturn(true);
        when(
          () => dao.watchRecentSessions(limit: any(named: 'limit')),
        ).thenAnswer((_) => Stream.value(const []));
      },
      build: buildCubit,
      act: (cubit) => cubit.init(),
      verify: (cubit) {
        expect(cubit.state.justOnboarded, isTrue);
        verifyNever(() => onboardingRepo.clearJustOnboarded());
      },
    );

    blocTest<TodayStatsCubit, TodayStatsState>(
      'clears the onboarding flag once a real session exists',
      setUp: () {
        when(() => onboardingRepo.isJustOnboarded()).thenReturn(true);
        when(
          () => dao.watchRecentSessions(limit: any(named: 'limit')),
        ).thenAnswer((_) => Stream.value([sessionAt(1, today)]));
      },
      build: buildCubit,
      act: (cubit) => cubit.init(),
      verify: (cubit) {
        expect(cubit.state.justOnboarded, isFalse);
        verify(() => onboardingRepo.clearJustOnboarded()).called(1);
      },
    );
  });
}
