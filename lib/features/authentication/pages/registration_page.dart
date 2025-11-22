import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5),
      appBar: AppBar(
        title: const Text('Choose Your Role'),
        backgroundColor: const Color(0xFF2C7D32),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'How will you use our app?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C7D32),
                ),
              ),
              const SizedBox(height: 40),
              _buildRoleCard(
                context,
                icon: Icons.agriculture, 
                title: 'Farmer',
                subtitle: 'I want to rent equipment',
                onTap: () => context.go('/signup', extra: 'Farmer'),
              ),
              const SizedBox(height: 20),
              _buildRoleCard(
                context,
                icon: Icons.store_mall_directory,
                title: 'Owner (Lender)',
                subtitle: 'I want to list my equipment',
                onTap: () => context.go('/signup', extra: 'Owner'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(icon, size: 50, color: const Color(0xFF2C7D32)),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
