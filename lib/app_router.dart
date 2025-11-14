import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/authentication/pages/login_page.dart';
import 'package:myapp/features/authentication/screens/signup_screen.dart';
import 'package:myapp/features/authentication/screens/verify_email_screen.dart';
import 'package:myapp/features/authentication/screens/welcome_screen.dart';
import 'package:myapp/features/equipment/pages/add_equipment_page.dart';
import 'package:myapp/features/equipment/pages/harvesters_page.dart';
import 'package:myapp/features/equipment/pages/pumps_page.dart';
import 'package:myapp/features/equipment/pages/tractors_page.dart';
import 'package:myapp/features/equipment/screens/equipment_detail_screen.dart';
import 'package:myapp/features/home/pages/main_screen.dart';
import 'package:myapp/go_router_refresh_stream.dart';

class AppRouter {
  final FirebaseAuth auth;

  AppRouter({required this.auth});

  late final router = GoRouter(
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomeScreen();
        },
      ),
       GoRoute(
        path: '/tractors',
        builder: (BuildContext context, GoRouterState state) {
          return const TractorsPage();
        },
      ),
      GoRoute(
        path: '/harvesters',
        builder: (BuildContext context, GoRouterState state) {
          return const HarvestersPage();
        },
      ),
      GoRoute(
        path: '/pumps',
        builder: (BuildContext context, GoRouterState state) {
          return const PumpsPage();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) {
          final role = state.uri.queryParameters['role'];
          return SignUpScreen(role: role);
        },
      ),
      GoRoute(
        path: '/verify-email',
        builder: (BuildContext context, GoRouterState state) {
          return const VerifyEmailScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const MainScreen(); // Main entry point for authenticated users
        },
        routes: [
          GoRoute(
            path: 'equipment/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return EquipmentDetailScreen(equipmentId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/add-equipment',
        builder: (BuildContext context, GoRouterState state) {
          return const AddEquipmentPage();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final user = auth.currentUser;
      final bool loggedIn = user != null;
      final bool emailVerified = user?.emailVerified ?? false;

      final String location = state.matchedLocation;
      final bool isAtAuthScreen = location == '/' || location == '/login' || location == '/signup';
      final bool isAtVerifyScreen = location == '/verify-email';

      // Case 1: User is not logged in.
      if (!loggedIn) {
        // If they are already on an auth screen, let them stay. Otherwise, redirect to welcome.
        return isAtAuthScreen ? null : '/';
      }

      // Case 2: User is logged in.
      // A) Email is not verified.
      if (!emailVerified) {
        // If they are not on the verify screen, send them there.
        return isAtVerifyScreen ? null : '/verify-email';
      }

      // B) Email is verified.
      if (emailVerified) {
        // If they are on an auth screen or the verify screen, send them home.
        if (isAtAuthScreen || isAtVerifyScreen) {
          return '/home';
        }
      }

      // Otherwise, no redirect needed.
      return null;
    },
  );
}
