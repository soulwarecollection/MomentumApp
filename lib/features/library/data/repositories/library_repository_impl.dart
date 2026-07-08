import 'package:drift/drift.dart' show Value;
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/library/domain/entities/exercise.dart';
import 'package:momentum/features/library/domain/repositories/library_repository.dart';

@LazySingleton(as: LibraryRepository)
class LibraryRepositoryImpl implements LibraryRepository {
  LibraryRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Exercise>> watchExercises({
    String? query,
    Modality? modality,
  }) {
    return _db.exercisesDao
        .watchExercises(query: query, modality: modality)
        .map((rows) => rows.map(_toEntity).toList());
  }

  @override
  TaskEither<Failure, Unit> createCustomExercise({
    required String name,
    required Modality modality,
    String? muscleGroup,
    String? equipment,
  }) {
    return TaskEither.tryCatch(
      () async {
        await _db.exercisesDao.insertExercise(
          ExercisesCompanion.insert(
            name: name,
            modality: modality,
            muscleGroup: Value(muscleGroup),
            equipment: Value(equipment),
            isCustom: const Value(true),
          ),
        );
        return unit;
      },
      (e, _) => CacheFailure(message: e.toString()),
    );
  }

  Exercise _toEntity(ExerciseRow row) => Exercise(
    id: row.id,
    name: row.name,
    modality: row.modality,
    muscleGroup: row.muscleGroup,
    equipment: row.equipment,
    isCustom: row.isCustom,
  );
}
