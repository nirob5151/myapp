import 'package:easyfarm/app/theme.dart';
import 'package:easyfarm/app_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
    return MaterialApp.router(
      routerConfig: router,
      title: 'EasyFarm',
      theme: themeData,
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to EasyFarm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to EasyFarm!',
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to Login Page
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to Sign Up Page
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
