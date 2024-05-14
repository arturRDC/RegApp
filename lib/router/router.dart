import 'package:go_router/go_router.dart';
import 'package:regapp/ui/HomePage.dart';
import 'package:regapp/ui/NewUserPage.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/newUser',
  routes: [
    GoRoute(
      path: '/newUser',
      builder: (context, state) => const NewUserPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
