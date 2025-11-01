import 'package:easyfarm/features/authentication/screens/auth_wrapper.dart';
import 'package:easyfarm/features/authentication/screens/login_screen.dart';
import 'package:easyfarm/features/authentication/screens/signup_screen.dart';
import 'package:easyfarm/features/authentication/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const AuthWrapper();
        },
        routes: [
          GoRoute(
            path: 'welcome',
            builder: (BuildContext context, GoRouterState state) {
              return const WelcomeScreen();
            },
          ),
        ]),
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
  ],
);
