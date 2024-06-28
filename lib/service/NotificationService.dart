import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()));
  }

  static pushNotification({required String title, required String body}) async {
    var androidDetails = const AndroidNotificationDetails(
        'important_channel', 'regapp_channel',
        importance: Importance.max, priority: Priority.high);

    var iosDetails = const DarwinNotificationDetails();

    var notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    _notification.show(100, title, body, notificationDetails);
  }
}
