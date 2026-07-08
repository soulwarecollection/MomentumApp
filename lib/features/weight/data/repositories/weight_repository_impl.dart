import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/weight/domain/repositories/weight_repository.dart';

@LazySingleton(as: WeightRepository)
class WeightRepositoryImpl implements WeightRepository {
  const WeightRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<WeightEntryRow>> watchAll() => _db.weightEntriesDao.watchAll();

  @override
  Stream<List<WeightEntryRow>> watchLast90Days() =>
      _db.weightEntriesDao.watchLast90Days();

  @override
  Future<WeightEntryRow?> getLatest() => _db.weightEntriesDao.getLatest();

  @override
  Future<void> addEntry({required double weightKg, String? note}) async {
    await _db.weightEntriesDao.insertEntry(
      WeightEntriesCompanion.insert(
        weightKg: weightKg,
        note: Value(note),
        recordedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> deleteEntry(int id) => _db.weightEntriesDao.deleteEntry(id);
}
