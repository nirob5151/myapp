import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/authentication/services/auth_service.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<String> _selectedRole = ValueNotifier<String>('Farmer');

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    final router = GoRouter.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final user = await authService.signUpWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
        _selectedRole.value,
      );
      if (user != null) {
        router.go('/');
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyFarm Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<String>(
                valueListenable: _selectedRole,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text('Farmer'),
                        selected: value == 'Farmer',
                        onSelected: (selected) {
                          if (selected) {
                            _selectedRole.value = 'Farmer';
                          }
                        },
                      ),
                      const SizedBox(width: 20),
                      ChoiceChip(
                        label: const Text('Owner'),
                        selected: value == 'Owner',
                        onSelected: (selected) {
                          if (selected) {
                            _selectedRole.value = 'Owner';
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
