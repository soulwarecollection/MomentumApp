import 'package:fpdart/fpdart.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/progress/domain/entities/raw_set.dart';
import 'package:momentum/features/progress/domain/entities/session_exercise_detail.dart';
import 'package:momentum/features/progress/domain/entities/session_summary.dart';

abstract class ProgressRepository {
  /// All done sets across every session, newest first — live stream.
  Stream<Either<Failure, List<RawSet>>> watchAllDoneSets();

  /// Live stream of calendar dates for all non-deleted sessions.
  Stream<Either<Failure, List<DateTime>>> watchSessionDates();

  /// Live stream of all session summaries, newest first.
  Stream<Either<Failure, List<SessionSummary>>> watchSessionSummaries();

  /// Done sets for a specific exercise (by exact name), newest first.
  TaskEither<Failure, List<RawSet>> getDoneSetsForExercise(String name);

  /// Calendar dates (with time stripped) for all non-deleted sessions.
  TaskEither<Failure, List<DateTime>> getSessionDates();

  /// Summarised list of all sessions, newest first.
  TaskEither<Failure, List<SessionSummary>> getSessionSummaries();

  /// Full detail for a single session.
  TaskEither<Failure, SessionSummary> getSessionSummary(int id);

  /// Exercises and their done sets for a session, in log order.
  TaskEither<Failure, List<SessionExerciseDetail>> getSessionExercises(
    int sessionId,
  );
}
