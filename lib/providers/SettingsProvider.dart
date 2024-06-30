import 'package:flutter/foundation.dart';

class SettingsProvider with ChangeNotifier {
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;

  void updateSettings({
    bool? notifications,
    bool? sound,
    bool? vibration,
  }) {
    if (notifications != null) {
      notificationsEnabled = notifications;
    }
    if (sound != null) {
      soundEnabled = sound;
    }
    if (vibration != null) {
      vibrationEnabled = vibration;
    }
    notifyListeners();
  }
}
