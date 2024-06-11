import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    notificationsEnabled = state;
  }

  void handleSoundSetting(bool state) {
    soundEnabled = state;
  }

  void handleVibrationSetting(bool state) {
    vibrationEnabled = state;
  }

  void handleSnoozeSetting(bool state) {
    snoozeEnabled = state;
  }

  @override
  Widget build(BuildContext context) {
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
                  onChanged: handleNotificationSetting,
                  isEnabled: true,
                ),
              ),
              SwitchSettingsItem(
                title: 'Reproduzir som',
                onChanged: handleSoundSetting,
                isEnabled: true,
              ),
              SwitchSettingsItem(
                title: 'Vibrar',
                onChanged: handleVibrationSetting,
                isEnabled: true,
              ),
              SwitchSettingsItem(
                title: 'Ativar Soneca',
                onChanged: handleSnoozeSetting,
                isEnabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
