import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/auth/controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth Screen'),
      ),
      body: Center(
        child: Text('Auth Screen'),
      ),
    );
  }
}
