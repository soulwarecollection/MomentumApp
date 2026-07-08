import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
sealed class Session with _$Session {
  const factory Session({
    required int id,
    required DateTime startedAt,
    required DateTime updatedAt,
    int? planId,
    int? dayIndex,
    String? focus,
    DateTime? endedAt,
    int? durationSeconds,
    String? note,
    DateTime? deletedAt,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
