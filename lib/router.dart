import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/auth/pages/login_page.dart';
import 'package:myapp/features/auth/pages/signup_page.dart';
import 'package:myapp/features/core/splash_screen.dart';
import 'package:myapp/features/farmer/pages/equipment_list_page.dart';
import 'package:myapp/features/farmer/pages/farmer_home_page.dart';
import 'package:myapp/features/owner/pages/add_equipment_page.dart';
import 'package:myapp/features/owner/pages/owner_home_page.dart';
import 'package:myapp/features/auth/services/user_service.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
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
        return const SignupPage();
      },
    ),
    GoRoute(
        path: '/farmer_home',
        builder: (BuildContext context, GoRouterState state) {
          return const FarmerHomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'equipment_list/:categoryId',
            builder: (BuildContext context, GoRouterState state) {
              final categoryId = state.pathParameters['categoryId']!;
              final categoryName = state.uri.queryParameters['categoryName']!;
              return EquipmentListPage(
                  categoryId: categoryId, categoryName: categoryName);
            },
          ),
        ]),
    GoRoute(
        path: '/owner_home',
        builder: (BuildContext context, GoRouterState state) {
          return const OwnerHomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'add_equipment',
            builder: (BuildContext context, GoRouterState state) {
              return const AddEquipmentPage();
            },
          ),
        ]),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    final auth = FirebaseAuth.instance;
    final userService = Provider.of<UserService>(context, listen: false);

    final bool loggedIn = auth.currentUser != null;
    final bool onAuthScreens =
        state.matchedLocation == '/login' || state.matchedLocation == '/signup';

    if (loggedIn && onAuthScreens) {
      final role = await userService.getUserRole(auth.currentUser!.uid);
      if (role == 'Farmer') {
        return '/farmer_home';
      } else if (role == 'Owner') {
        return '/owner_home';
      }
    }

    return null;
  },
  refreshListenable: StreamListenable(FirebaseAuth.instance.authStateChanges()),
);

class StreamListenable extends ChangeNotifier {
  StreamListenable(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}
