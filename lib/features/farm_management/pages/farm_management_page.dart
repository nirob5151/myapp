import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/authentication/services/auth_service.dart';
import 'package:myapp/features/farm_management/models/farm.dart';
import 'package:myapp/features/farm_management/models/crop.dart';
import 'package:myapp/features/farm_management/services/farm_service.dart';
import 'package:provider/provider.dart';

class FarmManagementPage extends StatelessWidget {
  const FarmManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Please log in to see your farms.'),
        ),
      );
    }

    final farmService = Provider.of<FarmService>(context);
    final farmsStream = farmService.getFarms(user.uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Farms'),
      ),
      body: StreamBuilder<List<Farm>>(
        stream: farmsStream,
        builder: (context, farmSnapshot) {
          if (farmSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (farmSnapshot.hasError) {
            return Center(child: Text('Error: ${farmSnapshot.error}'));
          }
          if (!farmSnapshot.hasData || farmSnapshot.data!.isEmpty) {
            return const Center(child: Text('No farms found. Add one!'));
          }
          final farms = farmSnapshot.data!;
          return ListView.builder(
            itemCount: farms.length,
            itemBuilder: (context, index) {
              final farm = farms[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text(farm.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(farm.location),
                  children: [
                    StreamBuilder<List<Crop>>(
                      stream: farmService.getCrops(farm.id!),
                      builder: (context, cropSnapshot) {
                        if (cropSnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (cropSnapshot.hasError) {
                          return Center(child: Text('Error: ${cropSnapshot.error}'));
                        }
                        if (!cropSnapshot.hasData || cropSnapshot.data!.isEmpty) {
                          return const Center(child: Text('No crops found.'));
                        }
                        final crops = cropSnapshot.data!;
                        return Column(
                          children: crops.map((crop) {
                            return ListTile(
                              title: Text(crop.name),
                              subtitle: Text('Planted: ${crop.plantingDate}, Harvest: ${crop.harvestDate}'),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Correctly navigate to AddCropPage
                        context.push('/add_crop', extra: farm.id);
                      },
                      child: const Text('Add Crop'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/add_farm');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
