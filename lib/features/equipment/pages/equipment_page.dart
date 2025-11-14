import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';
import 'package:provider/provider.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final equipmentService = Provider.of<EquipmentService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment'),
      ),
      body: StreamBuilder<List<Equipment>>(
        stream: equipmentService.getEquipment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No equipment available.'),
            );
          }

          final equipmentList = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: equipmentList.length,
            itemBuilder: (context, index) {
              final equipment = equipmentList[index];
              return Card(
                elevation: 2.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Image.network(
                    equipment.imageUrl,
                    width: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.construction, size: 50, color: Colors.grey),
                  ),
                  title: Text(equipment.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(equipment.description),
                      const SizedBox(height: 4.0),
                      Text(
                        '\$${equipment.price.toStringAsFixed(2)} / day',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  onTap: () => context.go('/home/equipment/${equipment.id}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/add-equipment');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
