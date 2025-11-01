import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/authentication/pages/login_page.dart';
import 'package:myapp/features/authentication/pages/signup_page.dart';
import 'package:myapp/features/authentication/services/auth_service.dart';
import 'package:myapp/features/farm_management/pages/add_crop_page.dart';
import 'package:myapp/features/farm_management/pages/add_farm_page.dart';
import 'package:myapp/features/farm_management/pages/farm_management_page.dart';
import 'package:myapp/features/home/pages/home_page.dart';

class AppRouter {
  final AuthService authService;

  AppRouter({required this.authService});

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
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
          return const SignUpPage();
        },
      ),
      GoRoute(
        path: '/farm_management',
        builder: (BuildContext context, GoRouterState state) {
          return const FarmManagementPage();
        },
      ),
      GoRoute(
        path: '/add_farm',
        builder: (BuildContext context, GoRouterState state) {
          return const AddFarmPage();
        },
      ),
      GoRoute(
        path: '/add_crop',
        builder: (BuildContext context, GoRouterState state) {
          final farmId = state.extra as String;
          return AddCropPage(farmId: farmId);
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = authService.currentUser != null;
      final bool loggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/signup';

      if (!loggedIn) {
        return loggingIn ? null : '/login';
      }

      if (loggingIn) {
        return '/';
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(authService.authStateChanges),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
