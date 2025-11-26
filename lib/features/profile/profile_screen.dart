
import 'package:flutter/material.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:myapp/utils/routes.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('John Doe'),
            accountEmail: Text('john.doe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://loremflickr.com/320/240/profile'),
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
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout
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
        ],
      ),
    );
  }
}
