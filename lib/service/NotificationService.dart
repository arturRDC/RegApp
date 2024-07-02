import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:regapp/models/Plant.dart';
import 'package:regapp/providers/SettingsProvider.dart';
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

class NotificationSettings {
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  NotificationSettings(
      {required this.notificationsEnabled,
      required this.soundEnabled,
      required this.vibrationEnabled});
}

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()));
  }

  static NotificationSettings providerToSettings(SettingsProvider provider) {
    return NotificationSettings(
        notificationsEnabled: provider.notificationsEnabled,
        soundEnabled: provider.soundEnabled,
        vibrationEnabled: provider.vibrationEnabled);
  }

  static int _getNotificationId(int plantId, int dayOfTheWeek) {
    return 7 * plantId + dayOfTheWeek;
  }

  static Future<void> cancelAllPlantNotifications(int plantId) async {
    var firstNoti = _getNotificationId(plantId, 1);
    var lastNoti = _getNotificationId(plantId, 7);
    for (var noti = firstNoti; noti <= lastNoti; noti++) {
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

  static Future<void> addPlantNotifications(
      String plantName,
      int plantId,
      Set<String> frequency,
      int hour,
      int minutes,
      NotificationSettings settings) async {
    for (var weekDay in frequency) {
      var wId = weekDayToId[weekDay]!;
      TZDateTime nextWeekDay = _getNextWeekDay(wId, hour, minutes);
      int notiId = _getNotificationId(plantId, wId);
      await weeklyScheduleNotification(
          nextWeekDay, notiId, plantName, settings);
    }
  }

  static Future<void> addAllPlantNotifications(
      NotificationSettings settings) async {
    if (!settings.notificationsEnabled) {
      return;
    }
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('plants')
        .get();
    List<Plant> plantList = [];

    for (var plant in snapshot.docs) {
      Plant plantObj = Plant(
          id: plant.id,
          title: plant['title'],
          imageUrl: plant['imageUrl'],
          waterNeeds: plant['waterNeeds'].toString(),
          location: plant['location'],
          frequency: Set<String>.from(plant['frequency']),
          time: plant['time'],
          plantId: plant['plantId']);
      plantList.add(plantObj);
    }
    for (var plant in plantList) {
      var timeParts = plant.time.split(':');
      var hour = int.parse(timeParts[0]);
      var minutes = int.parse(timeParts[1]);
      await addPlantNotifications(plant.title, plant.plantId!, plant.frequency,
          hour, minutes, settings);
    }
  }

  static String _getChannelName(bool soundEnabled, bool vibrationEnabled) {
    if (soundEnabled && vibrationEnabled) {
      return "Som com vibração";
    } else if (soundEnabled && !vibrationEnabled) {
      return "Som sem vibração";
    } else if (!soundEnabled && vibrationEnabled) {
      return "Silencioso sem vibração";
    } else {
      return "Som sem vibração";
    }
  }

  static Future<void> weeklyScheduleNotification(TZDateTime dateTime,
      int notiId, String plantName, NotificationSettings settings) async {
    if (!settings.notificationsEnabled) return;

    await _notification.zonedSchedule(
      notiId,
      '$plantName precisa de água!',
      'Lembre-se de regar sua planta: $plantName hoje.',
      dateTime,
      NotificationDetails(
          android: AndroidNotificationDetails(
              _getChannelName(settings.soundEnabled, settings.vibrationEnabled),
              _getChannelName(settings.soundEnabled, settings.vibrationEnabled),
              channelDescription: 'Lembretes para irrigações das plantas',
              playSound: settings.soundEnabled,
              enableVibration: settings.vibrationEnabled,
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

  static Future<void> updateNotifications(
      NotificationSettings settingsProvider) async {
    cancelAllNotifications();
    addAllPlantNotifications(settingsProvider);
  }
}
