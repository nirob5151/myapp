import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/authentication/pages/login_page.dart';
import 'package:myapp/features/authentication/pages/registration_page.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/pages/add_equipment_page.dart';
import 'package:myapp/features/equipment/pages/equipment_detail_page.dart';
import 'package:myapp/features/equipment/pages/harvesters_page.dart';
import 'package:myapp/features/equipment/pages/pumps_page.dart';
import 'package:myapp/features/equipment/pages/seeds_page.dart';
import 'package:myapp/features/equipment/pages/tractors_page.dart';
import 'package:myapp/features/equipment/pages/transport_vehicles_page.dart';
import 'package:myapp/features/home/pages/home_page.dart';
import 'package:myapp/features/marketplace/pages/marketplace_page.dart';
import 'package:myapp/features/my_farm/pages/my_farm_page.dart';
import 'package:myapp/features/profile/pages/edit_profile_page.dart';

class AppRouter {
  final FirebaseAuth auth;

  AppRouter({required this.auth});

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/equipment/:id',
        builder: (BuildContext context, GoRouterState state) {
          final equipment = state.extra as Equipment;
          return EquipmentDetailPage(equipment: equipment);
        },
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return const RegistrationPage();
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
        path: '/seeds',
        builder: (BuildContext context, GoRouterState state) {
          return const SeedsPage();
        },
      ),
      GoRoute(
        path: '/transport-vehicles',
        builder: (BuildContext context, GoRouterState state) {
          return const TransportVehiclesPage();
        },
      ),
      GoRoute(
        path: '/add-equipment',
        builder: (BuildContext context, GoRouterState state) {
          return const AddEquipmentPage();
        },
      ),
      GoRoute(
        path: '/my-farm',
        builder: (BuildContext context, GoRouterState state) {
          return const MyFarmPage();
        },
      ),
      GoRoute(
        path: '/marketplace',
        builder: (BuildContext context, GoRouterState state) {
          return const MarketplacePage();
        },
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (BuildContext context, GoRouterState state) {
          return const EditProfilePage();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = auth.currentUser != null;
      final bool loggingIn = state.matchedLocation == '/' || state.matchedLocation == '/register';

      if (!loggedIn) {
        return loggingIn ? null : '/';
      }
      if (loggingIn) {
        return '/home';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<User?> stream) {
    notifyListeners();
    stream.listen((_) => notifyListeners());
  }
}
