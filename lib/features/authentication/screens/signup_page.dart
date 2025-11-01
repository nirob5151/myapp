import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myapp/features/authentication/services/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedRole = 'Farmer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green.shade800),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            const SizedBox(height: 48.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person_outline, color: Colors.green.shade800),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined, color: Colors.green.shade800),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline, color: Colors.green.shade800),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone_outlined, color: Colors.green.shade800),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24.0),
            _buildRoleSelector(),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                final authService = context.read<AuthService>();
                final user = await authService.signUp(
                  _nameController.text,
                  _emailController.text,
                  _passwordController.text,
                  _selectedRole,
                  _phoneController.text,
                );
                if (user != null) {
                  if (!context.mounted) return;
                  context.go('/');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.green.shade700,
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            const Center(child: Text('or')),
            const SizedBox(height: 16.0),
            OutlinedButton(
              onPressed: () async {
                final authService = context.read<AuthService>();
                final user = await authService.signInWithGoogle();
                if (user != null) {
                  if (!context.mounted) return;
                  context.go('/home');
                }
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                side: BorderSide(color: Colors.green.shade700),
              ),
              child: Text(
                'Continue with Google',
                style: TextStyle(fontSize: 18.0, color: Colors.green.shade800),
              ),
            ),
            const SizedBox(height: 24.0),
            TextButton(
              onPressed: () => context.go('/'),
              child: Text(
                'Already have an account? Login',
                style: TextStyle(color: Colors.green.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRoleButton(context, 'Farmer', Icons.eco, () {
          setState(() {
            _selectedRole = 'Farmer';
          });
        }),
        _buildRoleButton(context, 'Owner (Lender)', Icons.business, () {
          setState(() {
            _selectedRole = 'Owner';
          });
        }),
      ],
    );
  }

  Widget _buildRoleButton(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    final isSelected = _selectedRole == (title.startsWith('Farmer') ? 'Farmer' : 'Owner');
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: isSelected ? 8.0 : 2.0,
        color: isSelected ? Colors.green.shade100 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: isSelected ? Colors.green.shade700 : Colors.transparent, width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Icon(icon, color: Colors.green.shade800, size: 40.0),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(color: Colors.green.shade800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
