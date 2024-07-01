import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regapp/providers/SettingsProvider.dart';
import 'package:regapp/service/NotificationService.dart';
import 'package:regapp/ui/components/SwitchSettingsItem.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

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
                      settingsProvider.updateSettings(
                          notifications: value, sound: false, vibration: false);
                    } else {
                      settingsProvider.updateSettings(notifications: value);
                    }
                    var notificationSettings =
                        NotificationService.providerToSettings(
                            settingsProvider);
                    NotificationService.updateNotifications(
                        notificationSettings);
                  },
                  isEnabled: settingsProvider.notificationsEnabled,
                ),
              ),
              SwitchSettingsItem(
                title: 'Reproduzir som',
                onChanged: (value) {
                  settingsProvider.updateSettings(sound: value);
                  var notificationSettings =
                      NotificationService.providerToSettings(settingsProvider);
                  NotificationService.updateNotifications(notificationSettings);
                },
                isEnabled: settingsProvider.soundEnabled,
              ),
              SwitchSettingsItem(
                title: 'Vibrar',
                onChanged: (value) {
                  settingsProvider.updateSettings(vibration: value);
                  var notificationSettings =
                      NotificationService.providerToSettings(settingsProvider);
                  NotificationService.updateNotifications(notificationSettings);
                },
                isEnabled: settingsProvider.vibrationEnabled,
              )
            ],
          ),
        ),
      ),
    );
  }
}
