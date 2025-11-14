
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/authentication/pages/login_page.dart';
import 'package:myapp/features/authentication/services/auth_service.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';
import 'package:myapp/features/home/pages/home_page.dart';
import 'package:myapp/features/user/user_service.dart';
import 'package:provider/provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

// A helper function to create the app with all necessary providers for testing.
Widget createTestableWidget({required Widget child, required FirebaseAuth auth}) {
  final firestore = FakeFirebaseFirestore();
  return MultiProvider(
    providers: [
      Provider<AuthService>(create: (_) => AuthService(auth: auth, firestore: firestore)),
      Provider<EquipmentService>(create: (_) => EquipmentService()),
      Provider<UserService>(create: (_) => UserService()),
    ],
    child: child,
  );
}

void main() {

  testWidgets('Renders the login page when not logged in', (WidgetTester tester) async {
    final auth = MockFirebaseAuth();
    // We are replacing the initial route with a Container to ensure the redirect is what
    // renders the LoginPage, not the initial route itself.
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const Scaffold(body: Center(child: Text("Initial Route")))),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      ],
      redirect: (context, state) {
        if (auth.currentUser == null) {
          return '/login';
        }
        return null;
      },
    );

    await tester.pumpWidget(createTestableWidget(
      auth: auth,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    ));

    await tester.pumpAndSettle();

    // Verify that the login page is shown.
    expect(find.byType(LoginPage), findsOneWidget);
    // Also verify the home page is not shown
    expect(find.byType(HomePage), findsNothing);
  });

  testWidgets('Redirects to the home page when logged in', (WidgetTester tester) async {
    final user = MockUser(isAnonymous: false, uid: 'some_uid', email: 'test@example.com');
    final auth = MockFirebaseAuth(mockUser: user, signedIn: true);
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      ],
      redirect: (context, state) {
        final loggedIn = auth.currentUser != null;
        if (loggedIn) {
          if (state.matchedLocation == '/login') return '/';
        }
        return null;
      },
    );

    await tester.pumpWidget(createTestableWidget(
      auth: auth,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    ));

    await tester.pumpAndSettle();

    // After login, the app should be showing the home page.
    expect(find.byType(HomePage), findsOneWidget);
    // Also verify the login page is not shown
    expect(find.byType(LoginPage), findsNothing);
  });
}
