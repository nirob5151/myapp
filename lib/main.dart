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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthService _authService;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    final authNotifier = ValueNotifier<User?>(_authService.currentUser);

    _authService.authStateChanges.listen((user) {
      authNotifier.value = user;
    });

    _appRouter = AppRouter(authNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => _authService,
        ),
        Provider<FarmService>(
          create: (_) => FarmService(),
        ),
        StreamProvider<User?>(
          create: (context) => _authService.authStateChanges,
          initialData: _authService.currentUser,
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
        routerConfig: _appRouter.router,
      ),
    );
  }
}
