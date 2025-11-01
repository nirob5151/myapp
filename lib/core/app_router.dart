import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/features/authentication/screens/login_page.dart';
import 'package:myapp/features/authentication/screens/signup_page.dart';
import 'package:myapp/features/authentication/screens/welcome_page.dart';
import 'package:myapp/features/home/screens/home_page.dart';
import 'package:myapp/features/farm_management/screens/farm_management_page.dart';

class AppRouter {
  final ValueNotifier<User?> authNotifier;

  AppRouter(this.authNotifier);

  late final GoRouter router = GoRouter(
    refreshListenable: authNotifier,
    initialLocation: '/welcome',
    routes: <GoRoute>[
      GoRoute(
        path: '/welcome',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) {
          return const SignupPage();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/farm-management',
        builder: (BuildContext context, GoRouterState state) {
          return const FarmManagementPage();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final loggedIn = authNotifier.value != null;
      final loggingIn = state.matchedLocation == '/' || state.matchedLocation == '/signup';
      final welcoming = state.matchedLocation == '/welcome';

      if (!loggedIn) {
        return welcoming ? null : loggingIn ? null : '/welcome';
      }

      if (loggingIn || welcoming) {
        return '/home';
      }

      return null;
    },
  );
}
