import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
