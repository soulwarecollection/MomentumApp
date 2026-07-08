import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/weight/domain/repositories/weight_repository.dart';
import 'package:momentum/features/weight/presentation/cubit/weight_state.dart';

@singleton
class WeightCubit extends Cubit<WeightState> {
  WeightCubit(this._repo) : super(const WeightState.loading());

  final WeightRepository _repo;
  StreamSubscription<List<WeightEntryRow>>? _allSub;
  StreamSubscription<List<WeightEntryRow>>? _chartSub;
  List<WeightEntryRow> _all = [];
  List<WeightEntryRow> _chart = [];

  void init() {
    _allSub = _repo.watchAll().listen(
      (rows) {
        _all = rows;
        _emit();
      },
      onError: (Object e) => emit(WeightState.error(e.toString())),
    );
    _chartSub = _repo.watchLast90Days().listen(
      (rows) {
        _chart = rows;
        _emit();
      },
      onError: (Object e) => emit(WeightState.error(e.toString())),
    );
  }

  void _emit() {
    emit(
      WeightState.ready(
        entries: _all,
        chartPoints: _chart,
        latest: _all.firstOrNull,
      ),
    );
  }

  Future<void> add(double weightKg, {String? note}) =>
      _repo.addEntry(weightKg: weightKg, note: note);

  Future<void> delete(int id) => _repo.deleteEntry(id);

  @override
  Future<void> close() {
    unawaited(_allSub?.cancel());
    unawaited(_chartSub?.cancel());
    return super.close();
  }
}
