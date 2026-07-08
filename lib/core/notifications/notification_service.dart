import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

const _restChannelId = 'rest_timer';
const _restChannelName = 'Rest Timer';
const _reminderChannelId = 'workout_reminder';
const _reminderChannelName = 'Workout Reminder';
const _goalChannelId = 'goal_nudge';
const _goalChannelName = 'Goal Nudge';
const _restNotifId = 1;
const _reminderNotifId = 2;
const _goalNotifId = 3;

class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    try {
      final tzInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(tzInfo.identifier));
    } on Object {
      // Fall back to UTC if we can't determine local timezone.
    }
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: darwin),
    );
    _ready = true;
  }

  Future<bool> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      return await ios?.requestPermissions(alert: true, sound: true) ?? false;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      return await android?.requestNotificationsPermission() ?? false;
    }
    return false;
  }

  /// Schedules a "rest complete" notification [seconds] from now.
  Future<void> scheduleRestComplete(int seconds) async {
    if (!_ready) return;
    await _plugin.cancel(id: _restNotifId);
    final scheduled = tz.TZDateTime.from(
      DateTime.now().add(Duration(seconds: seconds)),
      tz.local,
    );
    await _plugin.zonedSchedule(
      id: _restNotifId,
      title: 'Rest complete',
      body: 'Time to get back to it',
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _restChannelId,
          _restChannelName,
          channelDescription: 'Fires when the between-set rest timer ends',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelRestNotification() async {
    if (!_ready) return;
    await _plugin.cancel(id: _restNotifId);
  }

  /// Schedules a daily workout reminder at [hour]:[minute] (local time).
  Future<void> scheduleWorkoutReminder({
    required int hour,
    required int minute,
  }) async {
    if (!_ready) return;
    await _plugin.cancel(id: _reminderNotifId);
    final now = DateTime.now();
    var base = DateTime(now.year, now.month, now.day, hour, minute);
    if (base.isBefore(now)) base = base.add(const Duration(days: 1));
    final scheduled = tz.TZDateTime.from(base, tz.local);
    await _plugin.zonedSchedule(
      id: _reminderNotifId,
      title: 'Time to train',
      body: 'Open Momentum and log your workout.',
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _reminderChannelId,
          _reminderChannelName,
          channelDescription: 'Daily reminder to log your workout',
        ),
        iOS: DarwinNotificationDetails(presentAlert: true),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelWorkoutReminder() async {
    if (!_ready) return;
    await _plugin.cancel(id: _reminderNotifId);
  }

  /// Schedules (or replaces) the daily goal-nudge notification for 8 AM.
  /// The [title] and [body] are computed from current goal progress.
  Future<void> scheduleGoalNudge({
    required String title,
    required String body,
  }) async {
    if (!_ready) return;
    await _plugin.cancel(id: _goalNotifId);
    final now = DateTime.now();
    var base = DateTime(now.year, now.month, now.day, 8);
    if (base.isBefore(now)) base = base.add(const Duration(days: 1));
    final scheduled = tz.TZDateTime.from(base, tz.local);
    await _plugin.zonedSchedule(
      id: _goalNotifId,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _goalChannelId,
          _goalChannelName,
          channelDescription: 'Daily nudge toward your active goal',
        ),
        iOS: DarwinNotificationDetails(presentAlert: true),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelGoalNudge() async {
    if (!_ready) return;
    await _plugin.cancel(id: _goalNotifId);
  }
}
