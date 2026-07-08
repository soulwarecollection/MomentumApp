import 'dart:convert';

import 'package:drift/drift.dart';

/// Persists a `Map<String, double>` as a JSON string in SQLite.
///
/// Keys are metric names (e.g. `"weight"`, `"reps"`);
/// values are always [double].
class MetricsConverter extends TypeConverter<Map<String, double>, String> {
  const MetricsConverter();

  @override
  Map<String, double> fromSql(String fromDb) {
    final raw = jsonDecode(fromDb) as Map<String, dynamic>;
    return raw.map((k, v) => MapEntry(k, (v as num).toDouble()));
  }

  @override
  String toSql(Map<String, double> value) => jsonEncode(value);
}
