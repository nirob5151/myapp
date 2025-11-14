import 'package:flutter/material.dart';

class CropsPage extends StatelessWidget {
  const CropsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Crops')),
      body: const Center(
        child: Text('This is where you will manage your crops.'),
      ),
    );
  }
}
