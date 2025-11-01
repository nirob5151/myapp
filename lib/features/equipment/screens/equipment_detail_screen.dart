import 'package:flutter/material.dart';
import 'package:myapp/features/equipment/models/equipment.dart';

class EquipmentDetailScreen extends StatelessWidget {
  final String equipmentId;

  const EquipmentDetailScreen({super.key, required this.equipmentId});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch equipment details from Firestore using equipmentId

    // For now, using placeholder data
    final equipment = Equipment(
      id: equipmentId,
      name: 'Tractor',
      description: 'A powerful tractor for all your farming needs.',
      price: 100.0,
      imageUrl: 'https://via.placeholder.com/150',
      ownerId: 'owner123',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(equipment.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(equipment.imageUrl),
            const SizedBox(height: 16),
            Text(
              equipment.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              equipment.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${equipment.price}/day',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            // TODO: Display owner information
            const Text('Owner: John Doe'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement booking functionality
              },
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
