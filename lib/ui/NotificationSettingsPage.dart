import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:regapp/providers/SettingsProvider.dart';
import 'package:regapp/service/NotificationService.dart';
import 'package:regapp/ui/components/SettingsItem.dart';
import 'package:regapp/ui/components/SettingsItemRounded.dart';
import 'package:regapp/ui/components/SwitchSettingsItem.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool snoozeEnabled = true;

  void handleNotificationSetting(bool state) {
    setState(() {
      notificationsEnabled = state;
      if (state == false) {
        soundEnabled = false;
        vibrationEnabled = false;
        snoozeEnabled = false;
      }
    });
  }

  void handleSoundSetting(bool state) {
    setState(() {
      soundEnabled = state;
    });
  }

  void handleVibrationSetting(bool state) {
    setState(() {
      vibrationEnabled = state;
    });
  }

  void handleSnoozeSetting(bool state) {
    setState(() {
      snoozeEnabled = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notificações e alarmes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SwitchSettingsItem(
                  title: 'Ativar notificações',
                  onChanged: (value) {
                    if (!value) {
                      NotificationService.cancelAllNotifications();
                    } else {
                      NotificationService.addAllPlantNotifications();
                    }
                    settingsProvider.updateSettings(notifications: value);
                  },
                  isEnabled: settingsProvider.notificationsEnabled,
                ),
              ),
              SwitchSettingsItem(
                title: 'Reproduzir som',
                onChanged: (value) {
                  settingsProvider.updateSettings(sound: value);
                },
                isEnabled: settingsProvider.soundEnabled,
              ),
              SwitchSettingsItem(
                title: 'Vibrar',
                onChanged: (value) {
                  settingsProvider.updateSettings(vibration: value);
                },
                isEnabled: vibrationEnabled,
              ),
              SwitchSettingsItem(
                title: 'Ativar Soneca',
                onChanged: (value) {
                  settingsProvider.updateSettings(snooze: value);
                },
                isEnabled: settingsProvider.snoozeEnabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
