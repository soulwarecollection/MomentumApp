import 'dart:convert';

class ScheduleOverride {
  const ScheduleOverride({
    required this.planId,
    required this.dayIndex,
    this.scheduledDate,
  });

  factory ScheduleOverride.fromJson(Map<String, dynamic> json) =>
      ScheduleOverride(
        planId: json['planId'] as int,
        dayIndex: json['dayIndex'] as int,
        scheduledDate: json['scheduledDate'] != null
            ? DateTime.parse(json['scheduledDate'] as String)
            : null,
      );

  static ScheduleOverride? decode(String? raw) {
    if (raw == null) return null;
    return ScheduleOverride.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  final int planId;
  final int dayIndex;
  final DateTime? scheduledDate;

  ScheduleOverride copyWith({
    int? planId,
    int? dayIndex,
    DateTime? scheduledDate,
    bool clearDate = false,
  }) => ScheduleOverride(
    planId: planId ?? this.planId,
    dayIndex: dayIndex ?? this.dayIndex,
    scheduledDate: clearDate ? null : (scheduledDate ?? this.scheduledDate),
  );

  Map<String, Object?> toJson() => {
    'planId': planId,
    'dayIndex': dayIndex,
    'scheduledDate': scheduledDate?.toIso8601String(),
  };

  String encode() => jsonEncode(toJson());
}
