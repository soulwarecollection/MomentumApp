import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/sync/data/models/sync_record_model.dart';
import 'package:momentum/features/sync/sync_reconciler.dart';

AppDatabase _openDb() => AppDatabase(NativeDatabase.memory());

SyncRecordModel _plan({
  String id = 'plan-1',
  String? updatedAt,
  String? deletedAt,
  String name = 'PPL',
}) => SyncRecordModel(
  table: 'plans',
  id: id,
  clientUpdatedAt: updatedAt ?? _ts(0),
  deletedAt: deletedAt,
  data: {
    'name': name,
    'isActive': true,
    'currentDayIndex': 0,
    'createdAt': _ts(-1000),
  },
);

/// Unix seconds offset by [offsetSeconds] from now (Drift stores as seconds).
int _nowSec(int offsetSeconds) =>
    DateTime.now()
        .toUtc()
        .add(Duration(seconds: offsetSeconds))
        .millisecondsSinceEpoch ~/
    1000;

/// ISO-8601 UTC timestamp offset by [offsetSeconds] from now.
String _ts(int offsetSeconds) => DateTime.now()
    .toUtc()
    .add(Duration(seconds: offsetSeconds))
    .toIso8601String();

void main() {
  late AppDatabase db;
  late SyncReconciler reconciler;

  setUp(() {
    db = _openDb();
    reconciler = SyncReconciler(db);
  });

  tearDown(() => db.close());

  group('SyncReconciler', () {
    test('inserts new plan when no local row exists', () async {
      await reconciler.reconcile([_plan()]);

      final rows = await db
          .customSelect(
            "SELECT name, remote_id FROM plans WHERE remote_id = 'plan-1'",
          )
          .get();
      expect(rows, hasLength(1));
      expect(rows.first.data['name'], 'PPL');
    });

    test('updates plan when remote ts is newer', () async {
      await db.customStatement(
        'INSERT INTO plans '
        '(name, is_active, current_day_index, created_at, updated_at, '
        'remote_id) VALUES (?, 1, 0, ?, ?, ?)',
        ['Old Name', _nowSec(-200), _nowSec(-100), 'plan-1'],
      );

      await reconciler.reconcile([
        _plan(name: 'New Name', updatedAt: _ts(0)),
      ]);

      final rows = await db
          .customSelect(
            "SELECT name FROM plans WHERE remote_id = 'plan-1'",
          )
          .get();
      expect(rows.first.data['name'], 'New Name');
    });

    test('skips update when remote ts is older (local wins)', () async {
      await db.customStatement(
        'INSERT INTO plans '
        '(name, is_active, current_day_index, created_at, updated_at, '
        'remote_id) VALUES (?, 1, 0, ?, ?, ?)',
        ['Local Name', _nowSec(-200), _nowSec(100), 'plan-1'],
      );

      await reconciler.reconcile([
        _plan(name: 'Stale Remote', updatedAt: _ts(-50)),
      ]);

      final rows = await db
          .customSelect(
            "SELECT name FROM plans WHERE remote_id = 'plan-1'",
          )
          .get();
      expect(rows.first.data['name'], 'Local Name');
    });

    test('applies soft-delete when remote deletedAt is newer', () async {
      await db.customStatement(
        'INSERT INTO plans '
        '(name, is_active, current_day_index, created_at, updated_at, '
        'remote_id) VALUES (?, 1, 0, ?, ?, ?)',
        ['PPL', _nowSec(-200), _nowSec(-100), 'plan-1'],
      );

      await reconciler.reconcile([
        _plan(deletedAt: _ts(50), updatedAt: _ts(50)),
      ]);

      final rows = await db
          .customSelect(
            "SELECT deleted_at FROM plans WHERE remote_id = 'plan-1'",
          )
          .get();
      expect(rows.first.data['deleted_at'], isNotNull);
    });

    test('skips soft-delete when local ts is newer', () async {
      await db.customStatement(
        'INSERT INTO plans '
        '(name, is_active, current_day_index, created_at, updated_at, '
        'remote_id) VALUES (?, 1, 0, ?, ?, ?)',
        ['PPL', _nowSec(-200), _nowSec(200), 'plan-1'],
      );

      // Remote ts is older than local updated_at → skip
      await reconciler.reconcile([
        _plan(deletedAt: _ts(-10), updatedAt: _ts(-10)),
      ]);

      final rows = await db
          .customSelect(
            "SELECT deleted_at FROM plans WHERE remote_id = 'plan-1'",
          )
          .get();
      expect(rows.first.data['deleted_at'], isNull);
    });

    test(
      'processes records in dependency order (day before plan in input)',
      () async {
        final dayRecord = SyncRecordModel(
          table: 'plan_days',
          id: 'day-1',
          clientUpdatedAt: _ts(0),
          data: {
            'planRemoteId': 'plan-1',
            'orderIndex': 0,
            'focus': 'Push',
            'isRest': false,
          },
        );

        // plan_days listed first — reconciler must reorder to insert plan first
        await reconciler.reconcile([dayRecord, _plan()]);

        final dayRows = await db
            .customSelect(
              "SELECT id FROM plan_days WHERE remote_id = 'day-1'",
            )
            .get();
        expect(dayRows, hasLength(1));
      },
    );
  });
}
