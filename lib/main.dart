import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:regapp/firebase_options.dart';
import 'package:regapp/router/CustomNavigationHelper.dart';
import 'package:regapp/styles/colorSchemes.dart';
import 'package:regapp/styles/typography.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CustomNavigationHelper.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RegApp',
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: textTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(colorScheme.primary),
                foregroundColor:
                    MaterialStateProperty.all<Color>(colorScheme.onPrimary))),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        ),
        useMaterial3: true,
      ),
      routerConfig: CustomNavigationHelper.router,
    );
  }
}
