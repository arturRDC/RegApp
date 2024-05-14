import 'package:go_router/go_router.dart';
import 'package:regapp/ui/HomePage.dart';
import 'package:regapp/ui/SplashPage.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
