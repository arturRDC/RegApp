import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:regapp/ui/AddPlantPage.dart';
import 'package:regapp/ui/CreateAccountPage.dart';
import 'package:regapp/ui/EditPlantPage.dart';
import 'package:regapp/ui/LoginPage.dart';
import 'package:regapp/ui/NotificationSettingsPage.dart';
import 'package:regapp/ui/ResetPasswordPage.dart';
import 'package:regapp/ui/HomePage.dart';
import 'package:regapp/ui/IdentifyPlantErrorPage.dart';
import 'package:regapp/ui/IrrigationsPage.dart';
import 'package:regapp/ui/NewUserPage.dart';
import 'package:regapp/ui/PlantsPage.dart';
import 'package:regapp/ui/WeatherPage.dart';

import '../ui/SettingsPage.dart';
import '../ui/components/BottomNavigationPage.dart';

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
      CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> weatherTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> plantsTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> settingsTabNavigatorKey =
      GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static const String newUserPath = '/newUser';
  static const String createAccountPath = '/createAccount';
  static const String loginPath = '/login';
  static const String resetPasswordPath = '/resetPassword';

  static const String homePath = '/home';
  static const String weatherPath = '/weather';
  static const String plantsPath = '/plants';
  static const String settingsPath = '/settings';
  static const String notificationSettingsPath = '/settings/notifications';
  static const String irrigationsPath = '/irrigations';
  static const String addPlantsPath = '/plants/addPlant';
  static const String editPlantsPath = '/plants/editPlant/:id';
  static const String identifyPlantErrorPath = '/plants/identifyPlantError';

  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: homePath,
                name: 'Início',
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const HomePage(),
                    state: state,
                  );
                },
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: weatherTabNavigatorKey,
            routes: [
              GoRoute(
                path: weatherPath,
                name: 'Clima',
                pageBuilder: (context, state) {
                  return getPage(
                    child: const WeatherPage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: plantsTabNavigatorKey,
            routes: [
              GoRoute(
                path: plantsPath,
                name: 'Plantas',
                pageBuilder: (context, state) {
                  return getPage(
                    child: const PlantsPage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: settingsTabNavigatorKey,
            routes: [
              GoRoute(
                path: settingsPath,
                name: 'Configurações',
                pageBuilder: (context, state) {
                  return getPage(
                    child: const SettingsPage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
        ],
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return getPage(
            child: BottomNavigationPage(state: state, child: navigationShell),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: newUserPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const NewUserPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: createAccountPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const CreateAccount(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: irrigationsPath,
        name: 'Irrigações',
        pageBuilder: (context, GoRouterState state) {
          return getPage(
            child: const IrrigationsPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: addPlantsPath,
        name: 'Adicionar planta',
        pageBuilder: (context, GoRouterState state) {
          return getPage(
            child: const AddPlantPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: editPlantsPath,
        name: 'Editar planta',
        pageBuilder: (context, GoRouterState state) {
          final String pathId = state.pathParameters['id']!;
          return getPage(
            child: EditPlantPage(id: pathId),
            state: state,
          );
        },
      ),
      GoRoute(
        path: identifyPlantErrorPath,
        name: 'Identificar planta',
        pageBuilder: (context, GoRouterState state) {
          return getPage(
            child: const IdentifyPlantErrorPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: resetPasswordPath,
        name: 'Resetar senha',
        pageBuilder: (context, GoRouterState state) {
          return getPage(
            child: const ResetPasswordPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: loginPath,
        name: 'Login',
        pageBuilder: (context, GoRouterState state) {
          return getPage(
            child: const Login(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: notificationSettingsPath,
        name: 'Notificações e alarmes',
        pageBuilder: (context, GoRouterState state) {
          return getPage(
            child: const NotificationSettingsPage(),
            state: state,
          );
        },
      ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: newUserPath,
      redirect: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        // user is logged in and on the newUserPage
        if (user != null && state.fullPath == newUserPath) {
          return homePath;
        } else {
          // User is not logged in, allow navigation to new user page
          return null;
        }
      },
      routes: routes,
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
