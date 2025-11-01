import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen'),
      ),
      body: Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}
