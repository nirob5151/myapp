
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myapp/features/authentication/models/user.dart' as app_user;
import 'package:myapp/features/authentication/repositories/user_repository.dart';
import 'package:myapp/features/authentication/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final firebaseUser = authService.currentUser;

    if (firebaseUser == null) {
      // This view should not be reachable when logged out, but as a safeguard:
      return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: const Center(
          child: Text('You are not logged in.'),
        ),
      );
    }

    final userRepository = UserRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF00522E),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<app_user.UserModel?>(
        future: userRepository.getUser(firebaseUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Use Firestore data if available, otherwise fallback to FirebaseAuth data
          final userName = snapshot.hasData ? snapshot.data!.name : (firebaseUser.displayName ?? 'User');
          final userEmail = snapshot.hasData ? snapshot.data!.email : (firebaseUser.email ?? 'No email');
          const profileImageUrl = "https://cdn-icons-png.flaticon.com/512/147/147144.png"; // Placeholder avatar

          return Center(
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
                      context.go('/edit-profile');
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
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/rentals');
              break;
            case 2:
              // Add navigation to Live Chat page
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Rentals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Live Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color(0xFF00522E),
        unselectedItemColor: Colors.grey,
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
