import 'package:drift/drift.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/db/tables/weight_entries_table.dart';

part 'weight_entries_dao.g.dart';

@DriftAccessor(tables: [WeightEntries])
class WeightEntriesDao extends DatabaseAccessor<AppDatabase>
    with _$WeightEntriesDaoMixin {
  WeightEntriesDao(super.attachedDatabase);

  Stream<List<WeightEntryRow>> watchAll() => (select(
    weightEntries,
  )..orderBy([(t) => OrderingTerm.desc(t.recordedAt)])).watch();

  Stream<List<WeightEntryRow>> watchLast90Days() {
    final cutoff = DateTime.now().subtract(const Duration(days: 90));
    return (select(weightEntries)
          ..where((t) => t.recordedAt.isBiggerOrEqualValue(cutoff))
          ..orderBy([(t) => OrderingTerm.asc(t.recordedAt)]))
        .watch();
  }

  Future<WeightEntryRow?> getLatest() =>
      (select(weightEntries)
            ..orderBy([(t) => OrderingTerm.desc(t.recordedAt)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertEntry(WeightEntriesCompanion entry) =>
      into(weightEntries).insert(entry);

  Future<int> deleteEntry(int id) =>
      (delete(weightEntries)..where((t) => t.id.equals(id))).go();
}
