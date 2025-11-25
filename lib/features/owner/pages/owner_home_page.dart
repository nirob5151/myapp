import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/auth/services/auth_service.dart';
import 'package:myapp/features/owner/services/equipment_service.dart';
import 'package:myapp/features/owner/widgets/owner_equipment_card.dart';
import 'package:myapp/main.dart';
import 'package:myapp/models/equipment.dart';
import 'package:provider/provider.dart';

class OwnerHomePage extends StatelessWidget {
  const OwnerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final equipmentService = EquipmentService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Equipment'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              context.go('/login');
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Equipment>>(
        stream: equipmentService.getOwnerEquipment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No equipment found.'));
          }

          final equipmentList = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: equipmentList.length,
            itemBuilder: (context, index) {
              final equipment = equipmentList[index];
              return OwnerEquipmentCard(equipment: equipment);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/owner_home/add_equipment');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
