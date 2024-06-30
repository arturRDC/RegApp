import 'package:flutter/foundation.dart';

class SettingsProvider with ChangeNotifier {
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool snoozeEnabled = true;

  // Update the state variables
  void updateSettings(
      {bool notifications = true,
      bool sound = true,
      bool vibration = true,
      bool snooze = true}) {
    notificationsEnabled = notifications;
    soundEnabled = sound;
    vibrationEnabled = vibration;
    snoozeEnabled = snooze;
    notifyListeners();
  }
}
