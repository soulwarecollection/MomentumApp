import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/logging/domain/entities/logged_set.dart';
import 'package:momentum/features/logging/domain/entities/session.dart';
import 'package:momentum/features/logging/domain/entities/session_exercise.dart';

extension SessionRowMapper on SessionRow {
  Session toEntity() => Session(
    id: id,
    startedAt: startedAt,
    updatedAt: updatedAt,
    planId: planId,
    dayIndex: dayIndex,
    focus: focus,
    endedAt: endedAt,
    durationSeconds: durationSeconds,
    note: note,
    deletedAt: deletedAt,
  );
}

extension SessionExerciseRowMapper on SessionExerciseRow {
  SessionExercise toEntity() => SessionExercise(
    id: id,
    sessionId: sessionId,
    orderIndex: orderIndex,
    name: name,
    modality: modality,
    equipment: equipment?.name,
  );
}

extension LoggedSetRowMapper on LoggedSetRow {
  LoggedSet toEntity() => LoggedSet(
    id: id,
    sessionExerciseId: sessionExerciseId,
    orderIndex: orderIndex,
    modality: modality,
    metrics: metrics,
    isDone: isDone,
    createdAt: createdAt,
  );
}
