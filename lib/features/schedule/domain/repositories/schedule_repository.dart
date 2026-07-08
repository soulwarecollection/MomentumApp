import 'package:momentum/features/schedule/domain/entities/schedule_override.dart';

abstract class ScheduleRepository {
  ScheduleOverride? getOverride();

  Stream<void> get overrideChanges;

  Future<void> setOverride({
    required int planId,
    required int dayIndex,
    DateTime? scheduledDate,
  });

  Future<void> clearOverride();
}
