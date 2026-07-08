/// Matches the push/pull envelope the NestJS server uses.
class SyncRecordModel {
  const SyncRecordModel({
    required this.table,
    required this.id,
    required this.data,
    required this.clientUpdatedAt,
    this.deletedAt,
  });

  factory SyncRecordModel.fromJson(Map<String, dynamic> json) {
    return SyncRecordModel(
      table: json['table'] as String,
      id: json['id'] as String,
      data: Map<String, dynamic>.from(json['data'] as Map),
      clientUpdatedAt: (json['updatedAt'] ?? json['clientUpdatedAt']) as String,
      deletedAt: json['deletedAt'] as String?,
    );
  }

  final String table;

  /// Server-side UUID (== local remoteId once assigned).
  final String id;

  final Map<String, dynamic> data;

  /// Client's logical clock for last-write-wins on push.
  final String clientUpdatedAt;
  final String? deletedAt;

  Map<String, dynamic> toJson() => {
    'table': table,
    'id': id,
    'data': data,
    'clientUpdatedAt': clientUpdatedAt,
    if (deletedAt != null) 'deletedAt': deletedAt,
  };
}

class PushResponse {
  const PushResponse({required this.cursor});

  factory PushResponse.fromJson(Map<String, dynamic> json) =>
      PushResponse(cursor: json['cursor'] as String);

  final String cursor;
}

class PullResponse {
  const PullResponse({required this.records, required this.cursor});

  factory PullResponse.fromJson(Map<String, dynamic> json) => PullResponse(
    records: (json['records'] as List)
        .map(
          (r) => SyncRecordModel.fromJson(r as Map<String, dynamic>),
        )
        .toList(),
    cursor: json['cursor'] as String,
  );

  final List<SyncRecordModel> records;
  final String cursor;
}
