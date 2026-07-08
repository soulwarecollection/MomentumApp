import 'package:fpdart/fpdart.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/logging/domain/entities/exercise_entry.dart';
import 'package:momentum/features/logging/domain/entities/last_session_summary.dart';

abstract class LoggingRepository {
  TaskEither<Failure, int> createSession({
    int? planId,
    int? dayIndex,
    String? focus,
  });

  TaskEither<Failure, Unit> finishSession({
    required int sessionId,
    required DateTime endedAt,
    required int durationSeconds,
    required List<ExerciseEntry> exercises,
    int? planId,
    int? dayIndex,
  });

  /// Epley 1RM estimate for the named exercise across all prior strength sets.
  /// Returns null if no prior strength sets exist for this exercise.
  TaskEither<Failure, double?> getBestOneRepMax(String exerciseName);

  /// Set count and max weight from the most recent finished session that
  /// contained [exerciseName]. Returns null if no prior sessions exist.
  TaskEither<Failure, LastSessionSummary?> getLastSessionSummary(
    String exerciseName,
  );
}
