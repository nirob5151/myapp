
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:myapp/utils/routes.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = FirebaseAuth.instance.currentUser;

    String? displayName = user?.displayName ?? 'Guest';
    String? email = user?.email ?? 'No email';
    String? photoUrl = user?.photoURL;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(displayName),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: photoUrl != null
                  ? NetworkImage(photoUrl)
                  : const AssetImage('assets/images/placeholder.png') as ImageProvider,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Booking History'),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.bookingHistory);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            title: const Text('Toggle Theme'),
            onTap: () => themeProvider.toggleTheme(),
          ),
          ListTile(
            leading: const Icon(Icons.auto_mode),
            title: const Text('System Theme'),
            onTap: () => themeProvider.setSystemTheme(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
