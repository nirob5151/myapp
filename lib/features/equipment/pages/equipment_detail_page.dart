
import 'package:flutter/material.dart';

class EquipmentDetailPage extends StatelessWidget {
  final String equipmentId;

  const EquipmentDetailPage({super.key, required this.equipmentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment Detail'),
      ),
      body: Center(
        child: Text('Equipment ID: $equipmentId'),
      ),
    );
  }
}
