
import 'package:flutter/material.dart';

class PetFriendlyScreen extends StatefulWidget {
  const PetFriendlyScreen({super.key});

  @override
  State<PetFriendlyScreen> createState() => _PetFriendlyScreenState();
}

class _PetFriendlyScreenState extends State<PetFriendlyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet-Friendly Hotels'),
      ),
      body: Center(
        child: Text(
          'A list of pet-friendly hotels will be displayed here.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
