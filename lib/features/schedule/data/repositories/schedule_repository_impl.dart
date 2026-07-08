import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:momentum/features/schedule/domain/entities/schedule_override.dart';
import 'package:momentum/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ScheduleRepository)
class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'schedule_override';

  final _controller = StreamController<void>.broadcast();

  @override
  ScheduleOverride? getOverride() =>
      ScheduleOverride.decode(_prefs.getString(_key));

  @override
  Stream<void> get overrideChanges => _controller.stream;

  @override
  Future<void> setOverride({
    required int planId,
    required int dayIndex,
    DateTime? scheduledDate,
  }) async {
    final override = ScheduleOverride(
      planId: planId,
      dayIndex: dayIndex,
      scheduledDate: scheduledDate,
    );
    await _prefs.setString(_key, override.encode());
    _controller.add(null);
  }

  @override
  Future<void> clearOverride() async {
    await _prefs.remove(_key);
    _controller.add(null);
  }
}
