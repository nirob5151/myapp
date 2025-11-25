import 'package:flutter/material.dart';
import 'package:myapp/features/farmer/widgets/equipment_card.dart';
import 'package:myapp/features/owner/services/equipment_service.dart';
import 'package:myapp/models/equipment.dart';

class EquipmentListPage extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const EquipmentListPage(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final equipmentService = EquipmentService();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: StreamBuilder<List<Equipment>>(
        stream: equipmentService.getEquipmentByCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No equipment found in this category.'));
          }

          final equipmentList = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.8,
            ),
            itemCount: equipmentList.length,
            itemBuilder: (context, index) {
              final equipment = equipmentList[index];
              return EquipmentCard(equipment: equipment);
            },
          );
        },
      ),
    );
  }
}
