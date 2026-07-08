import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/onboarding/domain/repositories/onboarding_repository.dart';

class TodayStatsState {
  const TodayStatsState({
    this.weekDone = 0,
    this.streak = 0,
    this.recentSessions = const [],
    this.justOnboarded = false,
    this.streakAtRisk = false,
  });

  final int weekDone;
  final int streak;
  final List<SessionRow> recentSessions;

  /// True only in the gap between finishing onboarding and logging the
  /// first real session — lets the Today ring avoid a flat 0% right after
  /// the user has just built their plan.
  final bool justOnboarded;

  /// True when there's a live streak but nothing has been logged today —
  /// today is the last chance to keep it before it resets to zero.
  final bool streakAtRisk;
}

class TodayStatsCubit extends Cubit<TodayStatsState> {
  TodayStatsCubit({
    required SessionsDao dao,
    OnboardingRepository? onboardingRepo,
  }) : _dao = dao,
       _onboardingRepo = onboardingRepo,
       super(const TodayStatsState());

  final SessionsDao _dao;
  final OnboardingRepository? _onboardingRepo;
  StreamSubscription<List<SessionRow>>? _sub;

  void init() {
    _sub = _dao.watchRecentSessions(limit: 30).listen(_onSessions);
  }

  void _onSessions(List<SessionRow> sessions) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final monday = today.subtract(Duration(days: today.weekday - 1));

    final weekDone = sessions
        .where((s) => !s.startedAt.isBefore(monday))
        .length;

    final uniqueDays =
        sessions
            .map(
              (s) => DateTime(
                s.startedAt.year,
                s.startedAt.month,
                s.startedAt.day,
              ),
            )
            .toSet()
            .toList()
          ..sort((a, b) => b.compareTo(a));

    var streak = 0;
    DateTime? cursor;
    for (final day in uniqueDays) {
      if (cursor == null) {
        if (day == today || day == today.subtract(const Duration(days: 1))) {
          streak = 1;
          cursor = day;
        } else {
          break;
        }
      } else if (day == cursor.subtract(const Duration(days: 1))) {
        streak++;
        cursor = day;
      } else {
        break;
      }
    }

    final justOnboarded =
        sessions.isEmpty && (_onboardingRepo?.isJustOnboarded() ?? false);
    if (sessions.isNotEmpty) {
      unawaited(_onboardingRepo?.clearJustOnboarded());
    }

    final streakAtRisk =
        streak > 0 &&
        uniqueDays.isNotEmpty &&
        uniqueDays.first == today.subtract(const Duration(days: 1));

    emit(
      TodayStatsState(
        weekDone: weekDone,
        streak: streak,
        recentSessions: sessions.take(3).toList(),
        justOnboarded: justOnboarded,
        streakAtRisk: streakAtRisk,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
