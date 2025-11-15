
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myapp/features/authentication/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    // Dummy user data - replace with actual user data from your auth service
    const userName = "John Doe";
    const userEmail = "johndoe@email.com";
    const profileImageUrl = "https://cdn-icons-png.flaticon.com/512/147/147144.png"; // Placeholder avatar

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF00522E), // Dark green matching the design
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profileImageUrl),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 24),
              Text(
                userName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                userEmail,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 40),
              _buildProfileButton(
                text: 'Edit Profile',
                onPressed: () {
                  // Navigate to edit profile page
                },
              ),
              const SizedBox(height: 16),
              _buildProfileButton(
                text: 'Change Password',
                onPressed: () {
                  // Navigate to change password page
                },
              ),
              const SizedBox(height: 16),
              _buildProfileButton(
                text: 'Sign Out',
                onPressed: () async {
                  await authService.signOut();
                  context.go('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00522E), // Dark green
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0, // Flat design as per the image
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
