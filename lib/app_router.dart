import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/authentication/screens/login_screen.dart';
import 'package:myapp/features/authentication/screens/signup_screen.dart';
import 'package:myapp/features/authentication/screens/welcome_screen.dart';
import 'package:myapp/features/equipment/pages/add_equipment_page.dart';
import 'package:myapp/features/equipment/screens/equipment_detail_screen.dart';
import 'package:myapp/features/home/pages/home_page.dart';
import 'package:myapp/go_router_refresh_stream.dart';

class AppRouter {
  static final router = GoRouter(
    refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
    initialLocation: '/welcome',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomeScreen();
        },
      ),
      GoRoute(
        path: '/welcome',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomeScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: [
           GoRoute(
              path: 'equipment/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return EquipmentDetailScreen(equipmentId: id);
              }),
        ]
      ),
      GoRoute(
        path: '/add-equipment',
        builder: (BuildContext context, GoRouterState state) {
          return const AddEquipmentPage();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = FirebaseAuth.instance.currentUser != null;
      final bool loggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/signup' || state.matchedLocation == '/welcome' || state.matchedLocation == '/';

      if (!loggedIn && !loggingIn) {
        return '/welcome';
      }

      if (loggedIn && loggingIn) {
        return '/home';
      }

      return null;
    },
  );
}
