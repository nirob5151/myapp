'''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easyfarm/features/authentication/screens/login_page.dart';
import 'package:easyfarm/features/authentication/screens/signup_page.dart';
import 'package:easyfarm/main.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomePage();
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
  ],
);
''