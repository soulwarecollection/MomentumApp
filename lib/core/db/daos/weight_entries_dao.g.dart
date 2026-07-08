// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_entries_dao.dart';

// ignore_for_file: type=lint
mixin _$WeightEntriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $WeightEntriesTable get weightEntries => attachedDatabase.weightEntries;
  WeightEntriesDaoManager get managers => WeightEntriesDaoManager(this);
}

class WeightEntriesDaoManager {
  final _$WeightEntriesDaoMixin _db;
  WeightEntriesDaoManager(this._db);
  $$WeightEntriesTableTableManager get weightEntries =>
      $$WeightEntriesTableTableManager(_db.attachedDatabase, _db.weightEntries);
}
