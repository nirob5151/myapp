
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/authentication/models/user.dart';
import 'package:myapp/features/user/user_service.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userService = Provider.of<UserService>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5),
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xFF2C7D32), // Dark Green
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: user == null
          ? const Center(child: Text('No user logged in.'))
          : StreamBuilder<UserModel?>(
              stream: userService.getUserStream(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('User not found.'));
                }

                final userModel = snapshot.data!;
                final location = (userModel.division != null && userModel.country != null)
                    ? '${userModel.division}, ${userModel.country}'
                    : 'Location not set';

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        _buildProfileHeader(context, userModel, location),
                        const SizedBox(height: 30),
                        _buildMenuList(context),
                        const SizedBox(height: 30),
                        _buildLogoutButton(context),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserModel userModel, String location) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 60,
          backgroundColor: Color(0xFF2C7D32),
          child: Icon(Icons.person, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          userModel.name,
          style: const TextStyle(
            fontSize: 26, 
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          userModel.email,
          style: TextStyle(
            fontSize: 16, 
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          location,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          _buildMenuItem(
            context,
            icon: Icons.edit_outlined,
            title: 'Edit Profile',
            onTap: () => context.go('/edit-profile'),
          ),
          const Divider(height: 1),
          _buildMenuItem(
            context,
            icon: Icons.history_outlined,
            title: 'Rental History',
            onTap: () { /* Navigate to rental history */ },
          ),
          const Divider(height: 1),
          _buildMenuItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () { /* Navigate to settings */ },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2C7D32)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout, color: Colors.white),
      label: const Text('Logout', style: TextStyle(color: Colors.white)),
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        // The router's redirect logic will handle navigation to the login page.
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[700],
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
