import 'package:flutter/material.dart';
import 'package:myapp/features/farm_management/models/farm.dart';
import 'package:myapp/features/farm_management/services/farm_service.dart';
import 'package:provider/provider.dart';
import 'package:myapp/features/farm_management/pages/add_farm_page.dart';

class FarmManagementPage extends StatelessWidget {
  const FarmManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Management'),
      ),
      body: StreamBuilder<List<Farm>>(
        stream: context.read<FarmService>().getFarms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No farms found.'));
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
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddFarmPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
