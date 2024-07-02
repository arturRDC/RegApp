import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:regapp/service/NotificationService.dart';
import 'package:regapp/ui/components/SettingsItem.dart';
import 'package:regapp/ui/components/SettingsItemRounded.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int currentPageIndex = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  String? name;
  String? username;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    name = user?.displayName;
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    final docSnapshot =
        await _firestore.collection('users').doc(user?.uid).get();
    if (docSnapshot.exists) {
      setState(() {
        username = docSnapshot.data()?['username'];
      });
    }
  }

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
                textRight: username != null ? username! : '',
                onPress: () {},
              ),
            ),
            SettingsItem(
              title: 'Nome',
              textRight: name != null ? name! : '',
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
    NotificationService.cancelAllNotifications();
    context.go('/login');
  }
}
