import 'package:myapp/features/authentication/screens/auth_wrapper.dart';
import 'package:myapp/features/authentication/screens/login_screen.dart';
import 'package:myapp/features/authentication/screens/signup_screen.dart';
import 'package:myapp/features/authentication/screens/welcome_screen.dart';
import 'package:myapp/features/equipment/pages/add_equipment_page.dart';
import 'package:myapp/features/home/pages/home_page.dart';
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
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
          ),
          GoRoute(
            path: 'add-equipment',
            builder: (BuildContext context, GoRouterState state) {
              return const AddEquipmentPage();
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
