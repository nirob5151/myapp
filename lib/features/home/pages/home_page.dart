import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5), // Light background
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(child: _buildCategories(context)),
          SliverToBoxAdapter(child: _buildFeaturedAdsHeader(context)),
          _buildFeaturedAdsList(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 50.0, top: 50.0, left: 20.0, right: 20.0),
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
          const Text(
            'Farmer Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
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

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {'icon': Icons.agriculture, 'label': 'Tractors'},
      {'icon': Icons.settings_applications, 'label': 'Harvesters'},
      {'icon': Icons.local_drink, 'label': 'Pumps'},
      {'icon': Icons.devices_other, 'label': 'Accessories'},
      {'icon': Icons.add_shopping_cart, 'label': 'Rentals'},
      {'icon': Icons.more_horiz, 'label': 'More'},
    ];

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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 1.0, // Make items square
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                child: InkWell(
                  onTap: () {
                     if (category['label'] == 'Tractors') {
                      context.go('/tractors');
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(category['icon'] as IconData, size: 40.0, color: const Color(0xFF2C7D32)),
                      const SizedBox(height: 8.0),
                      Text(
                        category['label'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
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
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('No featured ads available.', style: TextStyle(color: Colors.grey)),
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
                  onTap: () => context.go('/home/equipment/${equipment.id}'),
                  child: Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    margin: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                      width: 180, // Adjust width as needed
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                            child: Image.network(
                                    equipment.imageUrl!,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => 
                                        const Icon(Icons.agriculture, size: 120, color: Colors.grey),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  equipment.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  equipment.isAvailable ? 'Available for Rent' : 'Currently Rented',
                                  style: TextStyle(
                                    color: equipment.isAvailable ? Colors.green : Colors.orange,
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
