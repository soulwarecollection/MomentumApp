import 'package:fpdart/fpdart.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/library/domain/entities/exercise.dart';

abstract class LibraryRepository {
  Stream<List<Exercise>> watchExercises({String? query, Modality? modality});

  TaskEither<Failure, Unit> createCustomExercise({
    required String name,
    required Modality modality,
    String? muscleGroup,
    String? equipment,
  });
}
