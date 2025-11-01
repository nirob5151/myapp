import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:myapp/features/authentication/services/auth_service.dart';
import 'package:myapp/features/farm_management/services/farm_service.dart';
import 'package:myapp/core/app_router.dart';
import 'package:myapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final authNotifier = ValueNotifier<User?>(authService.currentUser);

    authService.authStateChanges.listen((user) {
      authNotifier.value = user;
    });

    final router = AppRouter(authNotifier).router;

    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => authService,
        ),
        Provider<FarmService>(
          create: (_) => FarmService(),
        ),
        StreamProvider<User?>(
          create: (context) => authService.authStateChanges,
          initialData: authService.currentUser,
        ),
      ],
      child: MaterialApp.router(
        title: 'EasyFarm',
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routerConfig: router,
        // home: WelcomePage(), // We use router, so home is not needed
      ),
    );
  }
}
