
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/authentication/models/user.dart';
import 'package:myapp/features/user/user_service.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userService = Provider.of<UserService>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('My Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
                return _buildProfileView(context, userModel);
              },
            ),
    );
  }

  Widget _buildProfileView(BuildContext context, UserModel userModel) {
    final location = (userModel.division != null && userModel.country != null)
        ? '${userModel.division}, ${userModel.country}'
        : 'Location not set';

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileHeader(context, userModel, location),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildMenuList(context),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildLogoutButton(context),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserModel userModel, String location) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1596003906917-24a6a42dd831?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Placeholder image
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          child: CircleAvatar(
            radius: 65,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: userModel.photoUrl != null
                  ? NetworkImage(userModel.photoUrl!)
                  : const AssetImage('assets/placeholder_avatar.png') as ImageProvider, // Placeholder
            ),
          ),
        ),
        Positioned(
          top: 10, 
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.message_outlined, color: Colors.white),
            onPressed: () => context.push('/chat'),
            tooltip: 'Live Chat',
            ),
        ),
      ],
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          _buildMenuItem(
            context,
            icon: Icons.edit_outlined,
            title: 'Edit Profile',
            onTap: () => context.go('/edit-profile'),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
           _buildMenuItem(
            context,
            icon: Icons.list_alt_outlined,
            title: 'My Listings',
            onTap: () => context.go('/my-listings'),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildMenuItem(
            context,
            icon: Icons.history_outlined,
            title: 'Rental History',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildMenuItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout, color: Colors.white),
      label: Text('Logout', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade400,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
