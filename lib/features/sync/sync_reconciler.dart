import 'package:drift/drift.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/sync/data/models/sync_record_model.dart';

/// Applies a batch of pulled records from the server using last-write-wins.
///
/// Records are sorted into dependency order (plans → plan_days →
/// plan_exercises → sessions → session_exercises → logged_sets) before
/// processing, so FK parents always exist when children are inserted.
class SyncReconciler {
  const SyncReconciler(this._db);

  final AppDatabase _db;

  Future<void> reconcile(List<SyncRecordModel> records) async {
    final ordered = List.of(records)
      ..sort(
        (a, b) => _tableOrder
            .indexOf(a.table)
            .compareTo(_tableOrder.indexOf(b.table)),
      );
    for (final record in ordered) {
      await _apply(record);
    }
  }

  Future<void> _apply(SyncRecordModel record) async {
    switch (record.table) {
      case 'plans':
        await _applyPlan(record);
      case 'plan_days':
        await _applyPlanDay(record);
      case 'plan_exercises':
        await _applyPlanExercise(record);
      case 'sessions':
        await _applySession(record);
      case 'session_exercises':
        await _applySessionExercise(record);
      case 'logged_sets':
        await _applyLoggedSet(record);
    }
  }

  // ── Plans ────────────────────────────────────────────────────────────────

  Future<void> _applyPlan(SyncRecordModel r) async {
    final remoteTs = _parseTs(r.clientUpdatedAt);
    final existing = await _db.plansDao.getPlanByRemoteId(r.id);

    if (existing != null) {
      if (!remoteTs.isAfter(existing.updatedAt)) return;
      await _db.customStatement(
        '''
UPDATE plans SET name = ?, is_active = ?, current_day_index = ?,
  updated_at = ?, deleted_at = ?
WHERE remote_id = ?''',
        [
          r.data['name'] as String,
          _b(r.data['isActive'] as bool? ?? true),
          r.data['currentDayIndex'] as int? ?? 0,
          _toSec(remoteTs),
          _optSec(r.deletedAt),
          r.id,
        ],
      );
    } else {
      await _db.customStatement(
        '''
INSERT OR IGNORE INTO plans
  (name, is_active, current_day_index, created_at, updated_at, deleted_at, remote_id)
VALUES (?, ?, ?, ?, ?, ?, ?)''',
        [
          r.data['name'] as String,
          _b(r.data['isActive'] as bool? ?? true),
          r.data['currentDayIndex'] as int? ?? 0,
          _toSec(
            _parseTs(r.data['createdAt'] as String? ?? r.clientUpdatedAt),
          ),
          _toSec(remoteTs),
          _optSec(r.deletedAt),
          r.id,
        ],
      );
    }
  }

  // ── PlanDays ─────────────────────────────────────────────────────────────

  Future<void> _applyPlanDay(SyncRecordModel r) async {
    final remoteTs = _parseTs(r.clientUpdatedAt);
    final planRemoteId = r.data['planRemoteId'] as String?;
    if (planRemoteId == null) return;
    final parent = await _db.plansDao.getPlanByRemoteId(planRemoteId);
    if (parent == null) return;

    final row = await _rawRow('plan_days', r.id);
    if (row != null) {
      if (!_winsOver(remoteTs, row['updated_at'])) return;
      await _db.customStatement(
        '''
UPDATE plan_days SET order_index = ?, focus = ?, is_rest = ?,
  updated_at = ?, remote_id = ?
WHERE id = ?''',
        [
          r.data['orderIndex'] as int? ?? 0,
          r.data['focus'],
          _b(r.data['isRest'] as bool? ?? false),
          _toSec(remoteTs),
          r.id,
          row['id']! as int,
        ],
      );
    } else {
      await _db.customStatement(
        '''
INSERT OR IGNORE INTO plan_days
  (plan_id, order_index, focus, is_rest, updated_at, remote_id)
VALUES (?, ?, ?, ?, ?, ?)''',
        [
          parent.id,
          r.data['orderIndex'] as int? ?? 0,
          r.data['focus'],
          _b(r.data['isRest'] as bool? ?? false),
          _toSec(remoteTs),
          r.id,
        ],
      );
    }
  }

  // ── PlanExercises ────────────────────────────────────────────────────────

  Future<void> _applyPlanExercise(SyncRecordModel r) async {
    final remoteTs = _parseTs(r.clientUpdatedAt);
    final dayRemoteId = r.data['planDayRemoteId'] as String?;
    if (dayRemoteId == null) return;
    final parentDay = await _rawRow('plan_days', dayRemoteId);
    if (parentDay == null) return;

    final row = await _rawRow('plan_exercises', r.id);
    if (row != null) {
      if (!_winsOver(remoteTs, row['updated_at'])) return;
      await _db.customStatement(
        '''
UPDATE plan_exercises SET order_index = ?, name = ?, equipment = ?,
  target_sets = ?, scheme = ?, target = ?, updated_at = ?, remote_id = ?
WHERE id = ?''',
        [
          r.data['orderIndex'] as int? ?? 0,
          r.data['name'] as String,
          r.data['equipment'],
          r.data['targetSets'],
          r.data['scheme'],
          r.data['target'],
          _toSec(remoteTs),
          r.id,
          row['id']! as int,
        ],
      );
    } else {
      await _db.customStatement(
        '''
INSERT OR IGNORE INTO plan_exercises
  (plan_day_id, order_index, name, equipment,
   target_sets, scheme, target, updated_at, remote_id)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)''',
        [
          parentDay['id']! as int,
          r.data['orderIndex'] as int? ?? 0,
          r.data['name'] as String,
          r.data['equipment'],
          r.data['targetSets'],
          r.data['scheme'],
          r.data['target'],
          _toSec(remoteTs),
          r.id,
        ],
      );
    }
  }

  // ── Sessions ─────────────────────────────────────────────────────────────

  Future<void> _applySession(SyncRecordModel r) async {
    final remoteTs = _parseTs(r.clientUpdatedAt);
    final existing = await _db.sessionsDao.getSessionByRemoteId(r.id);

    int? planLocalId;
    final planRemoteId = r.data['planRemoteId'] as String?;
    if (planRemoteId != null) {
      planLocalId = (await _db.plansDao.getPlanByRemoteId(planRemoteId))?.id;
    }

    if (existing != null) {
      if (!remoteTs.isAfter(existing.updatedAt)) return;
      await _db.customStatement(
        '''
UPDATE sessions SET plan_id = ?, day_index = ?, focus = ?,
  started_at = ?, ended_at = ?, duration_seconds = ?,
  note = ?, updated_at = ?, deleted_at = ?
WHERE remote_id = ?''',
        [
          planLocalId,
          r.data['dayIndex'],
          r.data['focus'],
          _toSec(_parseTs(r.data['startedAt'] as String)),
          _optSec(r.data['endedAt'] as String?),
          r.data['durationSeconds'],
          r.data['note'],
          _toSec(remoteTs),
          _optSec(r.deletedAt),
          r.id,
        ],
      );
    } else {
      await _db.customStatement(
        '''
INSERT OR IGNORE INTO sessions
  (plan_id, day_index, focus, started_at, ended_at,
   duration_seconds, note, updated_at, deleted_at, remote_id)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)''',
        [
          planLocalId,
          r.data['dayIndex'],
          r.data['focus'],
          _toSec(_parseTs(r.data['startedAt'] as String)),
          _optSec(r.data['endedAt'] as String?),
          r.data['durationSeconds'],
          r.data['note'],
          _toSec(remoteTs),
          _optSec(r.deletedAt),
          r.id,
        ],
      );
    }
  }

  // ── SessionExercises ─────────────────────────────────────────────────────

  Future<void> _applySessionExercise(SyncRecordModel r) async {
    final remoteTs = _parseTs(r.clientUpdatedAt);
    final sessionRemoteId = r.data['sessionRemoteId'] as String?;
    if (sessionRemoteId == null) return;
    final parent = await _db.sessionsDao.getSessionByRemoteId(sessionRemoteId);
    if (parent == null) return;

    final row = await _rawRow('session_exercises', r.id);
    if (row != null) {
      if (!_winsOver(remoteTs, row['updated_at'])) return;
      await _db.customStatement(
        '''
UPDATE session_exercises SET order_index = ?, name = ?, equipment = ?,
  modality = ?, updated_at = ?, remote_id = ?
WHERE id = ?''',
        [
          r.data['orderIndex'] as int? ?? 0,
          r.data['name'] as String,
          r.data['equipment'],
          r.data['modality'] as String,
          _toSec(remoteTs),
          r.id,
          row['id']! as int,
        ],
      );
    } else {
      await _db.customStatement(
        '''
INSERT OR IGNORE INTO session_exercises
  (session_id, order_index, name, equipment, modality, updated_at, remote_id)
VALUES (?, ?, ?, ?, ?, ?, ?)''',
        [
          parent.id,
          r.data['orderIndex'] as int? ?? 0,
          r.data['name'] as String,
          r.data['equipment'],
          r.data['modality'] as String,
          _toSec(remoteTs),
          r.id,
        ],
      );
    }
  }

  // ── LoggedSets ───────────────────────────────────────────────────────────

  Future<void> _applyLoggedSet(SyncRecordModel r) async {
    final remoteTs = _parseTs(r.clientUpdatedAt);
    final seRemoteId = r.data['sessionExerciseRemoteId'] as String?;
    if (seRemoteId == null) return;
    final seRow = await _rawRow('session_exercises', seRemoteId);
    if (seRow == null) return;

    final row = await _rawRow('logged_sets', r.id);
    if (row != null) {
      if (!_winsOver(remoteTs, row['updated_at'])) return;
      await _db.customStatement(
        '''
UPDATE logged_sets SET order_index = ?, modality = ?, metrics = ?,
  is_done = ?, updated_at = ?, remote_id = ?
WHERE id = ?''',
        [
          r.data['orderIndex'] as int? ?? 0,
          r.data['modality'] as String,
          r.data['metrics'] as String,
          _b(r.data['isDone'] as bool? ?? false),
          _toSec(remoteTs),
          r.id,
          row['id']! as int,
        ],
      );
    } else {
      await _db.customStatement(
        '''
INSERT OR IGNORE INTO logged_sets
  (session_exercise_id, order_index, modality, metrics,
   is_done, created_at, updated_at, remote_id)
VALUES (?, ?, ?, ?, ?, ?, ?, ?)''',
        [
          seRow['id']! as int,
          r.data['orderIndex'] as int? ?? 0,
          r.data['modality'] as String,
          r.data['metrics'] as String,
          _b(r.data['isDone'] as bool? ?? false),
          _toSec(
            _parseTs(r.data['createdAt'] as String? ?? r.clientUpdatedAt),
          ),
          _toSec(remoteTs),
          r.id,
        ],
      );
    }
  }

  // ── Private helpers ──────────────────────────────────────────────────────

  static const _tableOrder = [
    'plans',
    'plan_days',
    'plan_exercises',
    'sessions',
    'session_exercises',
    'logged_sets',
  ];

  /// Returns `{id, updated_at}` for the row with [remoteId], or null.
  Future<Map<String, Object?>?> _rawRow(
    String table,
    String remoteId,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT id, updated_at FROM $table WHERE remote_id = ? LIMIT 1',
          variables: [Variable<String>(remoteId)],
        )
        .get();
    return rows.isEmpty ? null : rows.first.data;
  }

  /// True when [remoteTs] is strictly newer than the stored [rawUpdatedAt].
  /// Drift stores DateTimeColumn as Unix seconds; multiply by 1000 to get ms.
  static bool _winsOver(DateTime remoteTs, Object? rawUpdatedAt) {
    if (rawUpdatedAt == null) return true;
    final localTs = DateTime.fromMillisecondsSinceEpoch(
      (rawUpdatedAt as int) * 1000,
    );
    return remoteTs.isAfter(localTs);
  }

  static DateTime _parseTs(String iso) => DateTime.parse(iso).toUtc();

  /// Drift stores DateTimeColumn as Unix seconds (integer).
  static int _toSec(DateTime dt) => dt.millisecondsSinceEpoch ~/ 1000;

  static int? _optSec(String? iso) =>
      iso == null ? null : _toSec(_parseTs(iso));

  static int _b(bool v) => v ? 1 : 0;
}
