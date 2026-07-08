import 'package:drift/drift.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/db/seed_exercises.dart';
import 'package:momentum/core/db/tables/exercises_table.dart';
import 'package:momentum/core/enums/modality.dart';

part 'exercises_dao.g.dart';

@DriftAccessor(tables: [Exercises])
class ExercisesDao extends DatabaseAccessor<AppDatabase>
    with _$ExercisesDaoMixin {
  ExercisesDao(super.attachedDatabase);

  Future<void> seedIfEmpty() async {
    final count = countAll();
    final query = selectOnly(db.exercises)..addColumns([count]);
    final existing = (await query.getSingle()).read(count) ?? 0;
    if (existing > 0) return;

    await batch((b) {
      b.insertAll(
        db.exercises,
        kExerciseSeeds.map(
          (s) => ExercisesCompanion.insert(
            name: s.$1,
            modality: s.$2,
            muscleGroup: Value(s.$3),
            equipment: Value(s.$4),
          ),
        ),
      );
    });
  }

  Future<void> insertExercise(ExercisesCompanion companion) =>
      into(db.exercises).insert(companion);

  Stream<List<ExerciseRow>> watchExercises({
    String? query,
    Modality? modality,
  }) {
    return (select(db.exercises)
          ..where((t) {
            final conditions = <Expression<bool>>[];
            if (query != null && query.isNotEmpty) {
              conditions.add(
                t.name.lower().like('%${query.toLowerCase()}%'),
              );
            }
            if (modality != null) {
              conditions.add(t.modality.equalsValue(modality));
            }
            if (conditions.isEmpty) return const Constant(true);
            return conditions.reduce((a, b) => a & b);
          })
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }
}
