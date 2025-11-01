import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/features/authentication/services/auth_service.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('MyApp', style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Equipment>>(
        stream: Provider.of<EquipmentService>(context).getEquipment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final equipmentList = snapshot.data ?? [];
          if (equipmentList.isEmpty) {
            return Center(
              child: Text(
                'No equipment available for rent.',
                style: GoogleFonts.lato(fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: equipmentList.length,
            itemBuilder: (context, index) {
              final equipment = equipmentList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Image.network(
                    equipment.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.agriculture, size: 50),
                  ),
                  title: Text(equipment.name, style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                  subtitle: Text(equipment.description),
                  trailing: Text('\$${equipment.price}/day', style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
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
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
