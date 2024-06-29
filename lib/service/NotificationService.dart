import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()));
  }

  static pushNotification({required String title, required String body}) async {
    var androidDetails = const AndroidNotificationDetails(
        'important_channel', 'RegApp channel',
        importance: Importance.max, priority: Priority.high);

    var iosDetails = const DarwinNotificationDetails();

    var notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    _notification.show(100, title, body, notificationDetails);
  }

  static Future<void> weeklyScheduleNotification(
      DateTime dateTime, int hour, int minutes) async {
    await _notification.zonedSchedule(
      2000,
      'title',
      'body',
      tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.day, hour,
          minutes, dateTime.weekday),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'regapp_irrigations', 'Irrigações',
              channelDescription: 'Lembretes para irrigações das plantas',
              priority: Priority.high,
              importance: Importance.max)),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static Future<void> wateringNotification(String title, String body) async {
    await _notification.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'regapp_irrigations', 'Irrigações',
                channelDescription: 'Lembretes para irrigações das plantas',
                priority: Priority.high,
                importance: Importance.max)),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
