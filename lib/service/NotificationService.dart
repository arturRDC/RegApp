import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;

var weekDayToId = {
  'Seg': 1,
  'Ter': 2,
  'Qua': 3,
  'Qui': 4,
  'Sex': 5,
  'Sab': 6,
  'Dom': 7
};

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()));
  }

  static int _getNotificationId(int plantId, int dayOfTheWeek) {
    return 7 * plantId + dayOfTheWeek;
  }

  static Future<void> cancelAllPlantNotifications(int plantId) async {
    var firstNoti = _getNotificationId(plantId, 1);
    var lastNoti = _getNotificationId(plantId, 7);
    for (var noti = firstNoti; noti <= lastNoti; noti++) {
      print('Cancelling notification $noti for plant $plantId');
      _notification.cancel(noti);
    }
  }

  static Future<void> cancelAllNotifications() async {
    _notification.cancelAll();
  }

  static TZDateTime _getNextWeekDay(int wId, int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    while (scheduledDate.weekday != wId) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static Future<void> addPlantNotifications(String plantName, int plantId,
      Set<String> frequency, int hour, minutes) async {
    for (var weekDay in frequency) {
      var wId = weekDayToId[weekDay]!;
      TZDateTime nextWeekDay = _getNextWeekDay(wId, hour, minutes);
      int notiId = _getNotificationId(plantId, wId);
      await weeklyScheduleNotification(nextWeekDay, notiId, plantName);
    }
  }

  static Future<void> weeklyScheduleNotification(
      TZDateTime dateTime, int notiId, String plantName) async {
    print('Adding notification for day ${dateTime.weekday} with id $notiId');
    await _notification.zonedSchedule(
      notiId,
      '$plantName precisa de água!',
      'Lembre-se de regar sua planta: $plantName hoje.',
      dateTime,
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
