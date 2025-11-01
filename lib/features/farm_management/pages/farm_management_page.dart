import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
      return Scaffold(
        body: Center(
          child: Text(
            'Please log in to see your farms.',
            style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey[700]),
          ),
        ),
      );
    }

    final farmService = Provider.of<FarmService>(context);
    final farmsStream = farmService.getFarms(user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Farms', style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).primaryColor,
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.eco, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 20),
                  Text(
                    'No farms found. Start by adding a new farm!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey[700]),
                  ),
                ],
              ),
            );
          }
          final farms = farmSnapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: farms.length,
            itemBuilder: (context, index) {
              final farm = farms[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ExpansionTile(
                  title: Text(farm.name, style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Text(farm.location, style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey[600])),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: StreamBuilder<List<Crop>>(
                        stream: farmService.getCrops(farm.id!),
                        builder: (context, cropSnapshot) {
                          if (cropSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (cropSnapshot.hasError) {
                            return Center(child: Text('Error: ${cropSnapshot.error}'));
                          }
                          if (!cropSnapshot.hasData || cropSnapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                'No crops found. Add your first crop!',
                                style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey[600]),
                              ),
                            );
                          }
                          final crops = cropSnapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: crops.map((crop) {
                              return ListTile(
                                title: Text(crop.name, style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 18)),
                                subtitle: Text(
                                  'Planted: ${crop.plantingDate}\nHarvest: ${crop.harvestDate}',
                                  style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600]),
                                ),
                                leading: const Icon(Icons.grass, color: Colors.green),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.push('/add_crop', extra: farm.id);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Crop'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
