import 'dart:async';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/features/sync/data/datasources/sync_remote_datasource.dart';
import 'package:momentum/features/sync/data/models/sync_record_model.dart';
import 'package:momentum/features/sync/data/token_storage.dart';
import 'package:momentum/features/sync/sync_reconciler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const _cursorKey = 'sync_cursor';
const _maxRetries = 4;

class SyncService {
  SyncService({
    required AppDatabase db,
    required SyncRemoteDatasource remote,
    required TokenStorage tokenStorage,
    required SharedPreferences prefs,
  }) : _db = db,
       _remote = remote,
       _tokenStorage = tokenStorage,
       _prefs = prefs,
       _reconciler = SyncReconciler(db);

  final AppDatabase _db;
  final SyncRemoteDatasource _remote;
  final TokenStorage _tokenStorage;
  final SharedPreferences _prefs;
  final SyncReconciler _reconciler;
  final _uuid = const Uuid();

  bool _running = false;

  /// Fire-and-forget — safe to call from UI without awaiting.
  void syncInBackground() {
    if (_running) return;
    unawaited(_syncWithRetry());
  }

  Future<void> syncNow() => _syncWithRetry();

  Future<void> _syncWithRetry() async {
    if (!await _tokenStorage.hasTokens) return;
    _running = true;
    try {
      var delay = const Duration(seconds: 2);
      for (var attempt = 0; attempt <= _maxRetries; attempt++) {
        try {
          await _cycle();
          return;
        } on Object {
          if (attempt == _maxRetries) rethrow;
          await Future<void>.delayed(delay);
          delay = Duration(
            milliseconds: min(
              (delay.inMilliseconds * 2.0).round(),
              const Duration(minutes: 2).inMilliseconds,
            ),
          );
        }
      }
    } finally {
      _running = false;
    }
  }

  Future<void> _cycle() async {
    await _push();
    await _pull();
  }

  // ── Push ─────────────────────────────────────────────────────────────────

  Future<void> _push() async {
    final since = _cursorAsDate();
    final records = await _collectModified(since);
    if (records.isEmpty) return;
    final response = await _remote.push(records);
    await _prefs.setString(_cursorKey, response.cursor);
  }

  Future<List<SyncRecordModel>> _collectModified(DateTime? since) async {
    // Drift stores DateTimeColumn as Unix seconds.
    final epochSec =
        (since ?? DateTime.fromMillisecondsSinceEpoch(0))
            .millisecondsSinceEpoch ~/
        1000;
    final records = <SyncRecordModel>[];

    await _collectPlans(epochSec, records);
    await _collectPlanDays(epochSec, records);
    await _collectPlanExercises(epochSec, records);
    await _collectSessions(epochSec, records);
    await _collectSessionExercises(epochSec, records);
    await _collectLoggedSets(epochSec, records);

    return records;
  }

  Future<void> _collectPlans(
    int epochSec,
    List<SyncRecordModel> out,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT id, name, is_active, current_day_index, '
          'created_at, updated_at, deleted_at, remote_id '
          'FROM plans WHERE updated_at > ?',
          variables: [Variable<int>(epochSec)],
        )
        .get();

    for (final r in rows) {
      final d = r.data;
      final localId = d['id']! as int;
      final remoteId = await _ensureRemoteId(
        'plans',
        localId,
        d['remote_id'] as String?,
      );
      out.add(
        SyncRecordModel(
          table: 'plans',
          id: remoteId,
          clientUpdatedAt: _secToIso(d['updated_at']! as int),
          deletedAt: _optSecToIso(d['deleted_at'] as int?),
          data: {
            'name': d['name'] as String,
            'isActive': (d['is_active'] as int) == 1,
            'currentDayIndex': d['current_day_index'] as int,
            'createdAt': _secToIso(d['created_at']! as int),
          },
        ),
      );
    }
  }

  Future<void> _collectPlanDays(
    int epochSec,
    List<SyncRecordModel> out,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT id, plan_id, order_index, focus, is_rest, '
          'updated_at, remote_id FROM plan_days '
          'WHERE updated_at IS NOT NULL AND updated_at > ?',
          variables: [Variable<int>(epochSec)],
        )
        .get();

    for (final r in rows) {
      final d = r.data;
      final localId = d['id']! as int;
      final planRemoteId = await _remoteIdFor('plans', d['plan_id']! as int);
      if (planRemoteId == null) continue;
      final remoteId = await _ensureRemoteId(
        'plan_days',
        localId,
        d['remote_id'] as String?,
      );
      out.add(
        SyncRecordModel(
          table: 'plan_days',
          id: remoteId,
          clientUpdatedAt: _secToIso(d['updated_at']! as int),
          data: {
            'planRemoteId': planRemoteId,
            'orderIndex': d['order_index'] as int,
            'focus': d['focus'],
            'isRest': (d['is_rest'] as int) == 1,
          },
        ),
      );
    }
  }

  Future<void> _collectPlanExercises(
    int epochSec,
    List<SyncRecordModel> out,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT id, plan_day_id, order_index, name, equipment, '
          'target_sets, scheme, target, updated_at, remote_id '
          'FROM plan_exercises '
          'WHERE updated_at IS NOT NULL AND updated_at > ?',
          variables: [Variable<int>(epochSec)],
        )
        .get();

    for (final r in rows) {
      final d = r.data;
      final localId = d['id']! as int;
      final dayRemoteId = await _remoteIdFor(
        'plan_days',
        d['plan_day_id']! as int,
      );
      if (dayRemoteId == null) continue;
      final remoteId = await _ensureRemoteId(
        'plan_exercises',
        localId,
        d['remote_id'] as String?,
      );
      out.add(
        SyncRecordModel(
          table: 'plan_exercises',
          id: remoteId,
          clientUpdatedAt: _secToIso(d['updated_at']! as int),
          data: {
            'planDayRemoteId': dayRemoteId,
            'orderIndex': d['order_index'] as int,
            'name': d['name'] as String,
            'equipment': d['equipment'],
            'targetSets': d['target_sets'],
            'scheme': d['scheme'],
            'target': d['target'],
          },
        ),
      );
    }
  }

  Future<void> _collectSessions(
    int epochSec,
    List<SyncRecordModel> out,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT id, plan_id, day_index, focus, started_at, ended_at, '
          'duration_seconds, note, updated_at, deleted_at, remote_id '
          'FROM sessions WHERE updated_at > ?',
          variables: [Variable<int>(epochSec)],
        )
        .get();

    for (final r in rows) {
      final d = r.data;
      final localId = d['id']! as int;
      final planLocalId = d['plan_id'] as int?;
      String? planRemoteId;
      if (planLocalId != null) {
        planRemoteId = await _remoteIdFor('plans', planLocalId);
      }
      final remoteId = await _ensureRemoteId(
        'sessions',
        localId,
        d['remote_id'] as String?,
      );
      out.add(
        SyncRecordModel(
          table: 'sessions',
          id: remoteId,
          clientUpdatedAt: _secToIso(d['updated_at']! as int),
          deletedAt: _optSecToIso(d['deleted_at'] as int?),
          data: {
            'planRemoteId': planRemoteId,
            'dayIndex': d['day_index'],
            'focus': d['focus'],
            'startedAt': _secToIso(d['started_at']! as int),
            'endedAt': _optSecToIso(d['ended_at'] as int?),
            'durationSeconds': d['duration_seconds'],
            'note': d['note'],
          },
        ),
      );
    }
  }

  Future<void> _collectSessionExercises(
    int epochSec,
    List<SyncRecordModel> out,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT id, session_id, order_index, name, equipment, '
          'modality, updated_at, remote_id FROM session_exercises '
          'WHERE updated_at IS NOT NULL AND updated_at > ?',
          variables: [Variable<int>(epochSec)],
        )
        .get();

    for (final r in rows) {
      final d = r.data;
      final localId = d['id']! as int;
      final sessionRemoteId = await _remoteIdFor(
        'sessions',
        d['session_id']! as int,
      );
      if (sessionRemoteId == null) continue;
      final remoteId = await _ensureRemoteId(
        'session_exercises',
        localId,
        d['remote_id'] as String?,
      );
      out.add(
        SyncRecordModel(
          table: 'session_exercises',
          id: remoteId,
          clientUpdatedAt: _secToIso(d['updated_at']! as int),
          data: {
            'sessionRemoteId': sessionRemoteId,
            'orderIndex': d['order_index'] as int,
            'name': d['name'] as String,
            'equipment': d['equipment'],
            'modality': d['modality'] as String,
          },
        ),
      );
    }
  }

  Future<void> _collectLoggedSets(
    int epochSec,
    List<SyncRecordModel> out,
  ) async {
    final rows = await _db
        .customSelect(
          'SELECT id, session_exercise_id, order_index, modality, '
          'metrics, is_done, created_at, updated_at, remote_id '
          'FROM logged_sets '
          'WHERE updated_at IS NOT NULL AND updated_at > ?',
          variables: [Variable<int>(epochSec)],
        )
        .get();

    for (final r in rows) {
      final d = r.data;
      final localId = d['id']! as int;
      final seRemoteId = await _remoteIdFor(
        'session_exercises',
        d['session_exercise_id']! as int,
      );
      if (seRemoteId == null) continue;
      final remoteId = await _ensureRemoteId(
        'logged_sets',
        localId,
        d['remote_id'] as String?,
      );
      out.add(
        SyncRecordModel(
          table: 'logged_sets',
          id: remoteId,
          clientUpdatedAt: _secToIso(d['updated_at']! as int),
          data: {
            'sessionExerciseRemoteId': seRemoteId,
            'orderIndex': d['order_index'] as int,
            'modality': d['modality'] as String,
            'metrics': d['metrics'] as String,
            'isDone': (d['is_done'] as int) == 1,
            'createdAt': _secToIso(d['created_at']! as int),
          },
        ),
      );
    }
  }

  // ── Pull ─────────────────────────────────────────────────────────────────

  Future<void> _pull() async {
    final cursor = _prefs.getString(_cursorKey);
    final response = await _remote.pull(since: cursor);
    if (response.records.isNotEmpty) {
      await _reconciler.reconcile(response.records);
    }
    await _prefs.setString(_cursorKey, response.cursor);
  }

  // ── Raw helpers ───────────────────────────────────────────────────────────

  Future<String?> _remoteIdFor(String table, int localId) async {
    final rows = await _db
        .customSelect(
          'SELECT remote_id FROM $table WHERE id = ? LIMIT 1',
          variables: [Variable<int>(localId)],
        )
        .get();
    return rows.isEmpty ? null : rows.first.data['remote_id'] as String?;
  }

  Future<String> _ensureRemoteId(
    String table,
    int localId,
    String? existing,
  ) async {
    if (existing != null) return existing;
    final newId = _uuid.v4();
    await _db.customStatement(
      'UPDATE $table SET remote_id = ? WHERE id = ?',
      [newId, localId],
    );
    return newId;
  }

  DateTime? _cursorAsDate() {
    final s = _prefs.getString(_cursorKey);
    return s == null ? null : DateTime.tryParse(s)?.toUtc();
  }

  // Drift stores DateTimeColumn as Unix seconds; convert to ms for DateTime.
  static String _secToIso(int seconds) => DateTime.fromMillisecondsSinceEpoch(
    seconds * 1000,
    isUtc: true,
  ).toIso8601String();

  static String? _optSecToIso(int? seconds) =>
      seconds == null ? null : _secToIso(seconds);
}
