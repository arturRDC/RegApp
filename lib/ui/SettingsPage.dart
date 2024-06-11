import 'package:flutter/material.dart';
import 'package:regapp/ui/components/SettingsItem.dart';
import 'package:regapp/ui/components/SettingsItemRounded.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int currentPageIndex = 0;
  Map<String, String> user = {
    'username': 'joao.p.2001',
    'name': 'João Pedro',
  };
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: SettingsItemRounded(
              title: 'Nome de usuário',
              textRight: user['username']!,
              onPress: () {},
            ),
          ),
          SettingsItem(
            title: 'Nome',
            textRight: user['name']!,
            onPress: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SettingsItemRounded(title: 'Notificações', onPress: () {}),
          ),
          SettingsItem(
            title: 'Compartilhar plano',
            onPress: () {},
          ),
          SettingsItem(
            title: 'Alterar senha',
            onPress: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SettingsItemRounded(
              title: 'Nos Avalie',
              onPress: () {},
            ),
          ),
          SettingsItem(
            title: 'Política de privacidade',
            onPress: () {},
          ),
          SettingsItem(
            title: 'Termos de uso',
            onPress: () {},
          ),
          SettingsItem(
            title: 'Logout',
            onPress: () {},
          ),
        ],
      ),
    );
  }
}
