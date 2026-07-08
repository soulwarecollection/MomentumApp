import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/progress/domain/entities/orm_data_point.dart';
import 'package:momentum/features/progress/domain/entities/pr_record.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/enums/date_range.dart';
import 'package:momentum/features/progress/domain/repositories/progress_repository.dart';
import 'package:momentum/features/progress/domain/usecases/compute_orm_trend.dart';
import 'package:momentum/features/progress/domain/usecases/compute_volume_distribution.dart';
import 'package:momentum/features/progress/domain/usecases/compute_weekly_volume.dart';
import 'package:momentum/features/progress/presentation/cubits/progress_state.dart';

@injectable
class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit(this._repo) : super(const ProgressState.loading());

  final ProgressRepository _repo;

  static const _ormTrend = ComputeOrmTrend();
  static const _weeklyVolume = ComputeWeeklyVolume();
  static const _volDist = ComputeVolumeDistribution();

  StreamSubscription<dynamic>? _sub;

  Future<void> load() async {
    if (_sub != null) unawaited(_sub!.cancel());
    emit(const ProgressState.loading());
    _sub = _repo.watchAllDoneSets().listen(
      (result) => result.fold(_onError, _build),
      onError: (Object e) => _onError(CacheFailure(message: e.toString())),
    );
  }

  void _onError(Failure failure) => emit(ProgressState.error(failure.message));

  void setRange(DateRange range) {
    final s = state;
    if (s is! ProgressReady) return;
    emit(
      s.copyWith(
        selectedRange: range,
        filteredTrendPoints: _filterByRange(s.allTrendPoints, range),
      ),
    );
  }

  void _build(List<RawSet> sets) {
    final strengthSets = sets
        .where((s) => s.modality == Modality.strength)
        .toList();

    if (strengthSets.isEmpty) {
      emit(const ProgressState.empty());
      return;
    }

    final focusExercise = strengthSets.first.exerciseName;
    final focusSets = strengthSets
        .where((s) => s.exerciseName == focusExercise)
        .toList();

    final allTrendPoints = _ormTrend(focusSets);
    final estimated1rm = allTrendPoints.isEmpty
        ? 0.0
        : allTrendPoints.last.value;
    final ormSparkValues = allTrendPoints
        .map((p) => p.value)
        .toList()
        .reversed
        .take(6)
        .toList()
        .reversed
        .toList();

    final weekPoints = _weeklyVolume(strengthSets);
    final weekVolumeKg = weekPoints.isEmpty ? 0.0 : weekPoints.last.totalKg;
    final volumeSparkValues = weekPoints
        .map((p) => p.totalKg)
        .toList()
        .reversed
        .take(6)
        .toList()
        .reversed
        .toList();

    final now = DateTime.now();
    final weekStart = DateTime(
      now.year,
      now.month,
      now.day - (now.weekday - 1),
    );
    final weekSets = sets
        .where((s) => !s.sessionDate.isBefore(weekStart))
        .toList();
    final volumeDistribution = _volDist(weekSets);

    final prRecords = _buildPrRecords(focusSets, focusExercise, sets);

    const range = DateRange.oneMonth;
    emit(
      ProgressState.ready(
        focusExercise: focusExercise,
        estimated1rm: estimated1rm,
        ormSparkValues: ormSparkValues,
        weekVolumeKg: weekVolumeKg,
        volumeSparkValues: volumeSparkValues,
        allTrendPoints: allTrendPoints,
        filteredTrendPoints: _filterByRange(allTrendPoints, range),
        volumeDistribution: volumeDistribution,
        prRecords: prRecords,
        selectedRange: range,
      ),
    );
  }

  List<PrRecord> _buildPrRecords(
    List<RawSet> focusSets,
    String focusExercise,
    List<RawSet> allSets,
  ) {
    final records = <PrRecord>[];

    RawSet? heaviest;
    for (final s in focusSets) {
      final w = s.metrics['weight'] ?? 0;
      if (heaviest == null || w > (heaviest.metrics['weight'] ?? 0)) {
        heaviest = s;
      }
    }
    if (heaviest != null) {
      final w = heaviest.metrics['weight'] ?? 0;
      final r = heaviest.metrics['reps'] ?? 0;
      records.add(
        PrRecord(
          type: PrType.heaviestSet,
          exerciseName: focusExercise,
          value: w,
          unit: 'kg',
          achievedAt: heaviest.sessionDate,
          reps: r.round(),
        ),
      );
    }

    final volumeBySession = <int, double>{};
    for (final s in allSets) {
      if (s.modality != Modality.strength) continue;
      final w = s.metrics['weight'] ?? 0;
      final r = s.metrics['reps'] ?? 0;
      if (w > 0 && r > 0) {
        volumeBySession[s.sessionId] =
            (volumeBySession[s.sessionId] ?? 0) + w * r;
      }
    }
    if (volumeBySession.isNotEmpty) {
      final best = volumeBySession.entries.reduce(
        (a, b) => a.value >= b.value ? a : b,
      );
      final sessionDate = allSets
          .firstWhere((s) => s.sessionId == best.key)
          .sessionDate;
      records.add(
        PrRecord(
          type: PrType.bestSessionVolume,
          exerciseName: 'Best session',
          value: best.value,
          unit: 'kg',
          achievedAt: sessionDate,
        ),
      );
    }

    return records;
  }

  List<OrmDataPoint> _filterByRange(
    List<OrmDataPoint> points,
    DateRange range,
  ) {
    final days = range.days;
    if (days == null) return points;
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return points.where((p) => p.date.isAfter(cutoff)).toList();
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
