import 'package:flutter/material.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';
import 'package:myapp/features/user/user_model.dart';
import 'package:myapp/features/user/user_service.dart';
import 'package:provider/provider.dart';

class EquipmentDetailScreen extends StatelessWidget {
  final String equipmentId;

  const EquipmentDetailScreen({super.key, required this.equipmentId});

  @override
  Widget build(BuildContext context) {
    final equipmentService = EquipmentService();
    final userService = Provider.of<UserService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment Details'),
      ),
      body: FutureBuilder<Equipment?>(
        future: equipmentService.getEquipmentById(equipmentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Equipment not found'));
          }

          final equipment = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (equipment.imageUrls.isNotEmpty)
                  Image.network(
                    equipment.imageUrls.first,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image, size: 100),
                  ),
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
                FutureBuilder<UserModel?>(
                  future: userService.getUser(equipment.ownerId),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading owner info...');
                    }
                    if (userSnapshot.hasError || !userSnapshot.hasData) {
                      return const Text('Owner: Not available');
                    }
                    final owner = userSnapshot.data!;
                    return Text('Owner: ${owner.name}');
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement booking functionality
                  },
                  child: const Text('Book Now'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
