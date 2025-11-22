import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/equipment/data/dummy_equipment.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';
import 'package:myapp/features/home/models/category.dart';
import 'package:myapp/features/home/services/category_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Method to seed the database
  void _seedDatabase(BuildContext context) async {
    final equipmentService =
        Provider.of<EquipmentService>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      // A simple check to prevent re-seeding.
      final existingEquipment = await equipmentService.getEquipment().first;
      if (existingEquipment.isNotEmpty) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Database already contains data.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      for (final equipment in allDummyEquipment) {
        // Firestore will generate a unique ID automatically
        await equipmentService.addEquipment(equipment);
      }

      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Database seeded successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Error seeding database: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5), // Light background
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(child: _buildQuickActions(context)),
          SliverToBoxAdapter(child: _buildCategories(context)),
          SliverToBoxAdapter(child: _buildFeaturedAdsHeader(context)),
          _buildFeaturedAdsList(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(bottom: 50.0, top: 50.0, left: 20.0, right: 20.0),
      decoration: const BoxDecoration(
        color: Color(0xFF2C7D32), // Darker Green
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Farmer Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          TextField(
            decoration: InputDecoration(
              hintText: 'tractors, harvesters, pumps...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickActionButton(
            context,
            icon: Icons.add_circle_outline,
            label: 'Add Equipment',
            onTap: () => context.go('/add-equipment'),
          ),
          _buildQuickActionButton(
            context,
            icon: Icons.storefront,
            label: 'Marketplace',
            onTap: () => context.go('/marketplace'),
          ),
          _buildQuickActionButton(
            context,
            icon: Icons.eco,
            label: 'My Farm',
            onTap: () => context.go('/my-farm'),
          ),
          _buildQuickActionButton(
            context,
            icon: Icons.storage,
            label: 'Seed DB',
            onTap: () => _seedDatabase(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF2C7D32), size: 30.0),
          const SizedBox(height: 8.0),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          FutureBuilder<List<Category>>(
            future: categoryService.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No categories found.'));
              }

              final categories = snapshot.data!;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: InkWell(
                      onTap: () => context.go(category.route),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category.icon,
                              size: 40.0, color: const Color(0xFF2C7D32)),
                          const SizedBox(height: 8.0),
                          Text(
                            category.label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedAdsHeader(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 15.0),
      child: Text(
        'Featured Ads',
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFeaturedAdsList(BuildContext context) {
    final equipmentService = Provider.of<EquipmentService>(context, listen: false);

    return StreamBuilder<List<Equipment>>(
      stream: equipmentService.getEquipment(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child:
                    Text('No featured ads. Try seeding the database.', style: TextStyle(color: Colors.grey)),
              ),
            ),
          );
        }

        final equipmentList = snapshot.data!;
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 220.0, // Adjust height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: equipmentList.length,
              itemBuilder: (context, index) {
                final equipment = equipmentList[index];
                return GestureDetector(
                  onTap: () => context.go('/equipment/${equipment.id}', extra: equipment),
                  child: Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    margin: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                      width: 180, // Adjust width as needed
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15.0)),
                            child: equipment.imageUrls.isNotEmpty
                                ? Image.network(
                                    equipment.imageUrls.first,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.agriculture,
                                            size: 120, color: Colors.grey),
                                  )
                                : const Icon(Icons.agriculture, size: 120, color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  equipment.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  equipment.isAvailable
                                      ? 'Available for Rent'
                                      : 'Currently Rented',
                                  style: TextStyle(
                                    color: equipment.isAvailable
                                        ? Colors.green
                                        : Colors.orange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
