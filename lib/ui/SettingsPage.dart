import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return SingleChildScrollView(
      child: Padding(
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
              child: SettingsItemRounded(
                  title: 'Notificações e alarmes',
                  onPress: () => context.push('/settings/notifications')),
            ),
            SettingsItem(
              title: 'Compartilhar plano',
              onPress: () {},
            ),
            SettingsItem(
              title: 'Alterar senha',
              onPress: () => context.push('/resetPassword'),
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
              onPress: () => {_logout()},
            ),
          ],
        ),
      ),
    );
  }

  void _logout() async {
    FirebaseAuth.instance.signOut();
    context.go('/login');
  }
}
