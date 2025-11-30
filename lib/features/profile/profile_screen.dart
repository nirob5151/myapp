
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:myapp/utils/routes.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 32),
              _buildSettingsSection(context, themeProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Laiba Ahmar',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'youremail@domain.com | +01 234 567 89',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context, ThemeProvider themeProvider) {
    return Column(
      children: [
        _buildSettingsCard(
          children: [
            _buildSettingsTile(
              icon: Icons.edit,
              title: 'Edit profile information',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.book_online,
              title: 'My Bookings',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.bookingHistory);
              },
            ),
            _buildSettingsTile(
              icon: Icons.notifications,
              title: 'Notifications',
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.language,
              title: 'Language',
              trailing: const Text(
                'English',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSettingsCard(
          children: [
            _buildSettingsTile(
              icon: Icons.security,
              title: 'Security',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.color_lens,
              title: 'Theme',
              trailing: const Text(
                'Light mode',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSettingsCard(
          children: [
            _buildSettingsTile(
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.contact_mail,
              title: 'Contact us',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.privacy_tip,
              title: 'Privacy policy',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSettingsCard(
          children: [
            _buildSettingsTile(
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              trailing: Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              ),
              onTap: () {
                themeProvider.toggleTheme(themeProvider.themeMode == ThemeMode.light);
              },
            ),
            _buildSettingsTile(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.login, (route) => false);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
