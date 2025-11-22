import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';
import 'package:provider/provider.dart';

class OwnerListingsPage extends StatelessWidget {
  const OwnerListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final equipmentService = Provider.of<EquipmentService>(context);
    final user = Provider.of<User?>(context);
    final theme = Theme.of(context);

    if (user == null) {
      return const Center(child: Text('Please log in to see your listings.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Equipment Listings'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: StreamBuilder<List<Equipment>>(
        stream: equipmentService.getEquipmentByOwner(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'You have not listed any equipment yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final equipmentList = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: equipmentList.length,
            itemBuilder: (context, index) {
              final equipment = equipmentList[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: equipment.imageUrls.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            equipment.imageUrls.first,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.agriculture, size: 50),
                          ),
                        )
                      : const Icon(Icons.agriculture, size: 50),
                  title: Text(
                    equipment.name,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        '\${equipment.price.toStringAsFixed(2)} / day',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        equipment.isAvailable ? 'Available' : 'Unavailable',
                        style: TextStyle(
                          color: equipment.isAvailable ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Implement navigation to an edit/details page
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
