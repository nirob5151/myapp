import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/farm_management/models/farm.dart';
import 'package:myapp/features/farm_management/services/farm_service.dart';
import 'package:provider/provider.dart';

class FarmManagementPage extends StatelessWidget {
  const FarmManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final farmService = Provider.of<FarmService>(context);
    // Replace 'YOUR_OWNER_ID' with the actual owner ID from your auth system
    final farmsStream = farmService.getFarms('YOUR_OWNER_ID');

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Farms'),
      ),
      body: StreamBuilder<List<Farm>>(
        stream: farmsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No farms found. Add one!'));
          }
          final farms = snapshot.data!;
          return ListView.builder(
            itemCount: farms.length,
            itemBuilder: (context, index) {
              final farm = farms[index];
              return ListTile(
                title: Text(farm.name),
                subtitle: Text(farm.location),
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
