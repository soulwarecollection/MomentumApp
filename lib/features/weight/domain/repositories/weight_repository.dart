import 'package:momentum/core/db/app_database.dart';

abstract class WeightRepository {
  Stream<List<WeightEntryRow>> watchAll();
  Stream<List<WeightEntryRow>> watchLast90Days();
  Future<WeightEntryRow?> getLatest();
  Future<void> addEntry({required double weightKg, String? note});
  Future<void> deleteEntry(int id);
}
