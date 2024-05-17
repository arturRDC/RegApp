import 'package:flutter/material.dart';
import 'package:regapp/router/router.dart';
import 'package:regapp/styles/colorSchemes.dart';
import 'package:regapp/styles/typography.dart';

void main() {
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
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
