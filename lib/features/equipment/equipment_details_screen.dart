
import 'package:flutter/material.dart';
import 'package:myapp/features/booking/booking_screen.dart';
import 'package:myapp/models/equipment.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EquipmentDetailsScreen extends StatelessWidget {
  final Equipment equipment;

  const EquipmentDetailsScreen({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(equipment.name, style: const TextStyle(shadows: [Shadow(blurRadius: 10)])),
              background: CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  autoPlay: true,
                  viewportFraction: 1.0,
                ),
                items: equipment.imageUrls.map((item) => Container(
                  child: Center(
                    child: Image.network(item, fit: BoxFit.cover, height: 300)
                  ),
                )).toList(),
              ),
            ),
             actions: [
              IconButton(
                icon: const Icon(Icons.call),
                onPressed: () {
                  // TODO: Implement call functionality
                },
                tooltip: 'Call Owner',
              ),
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  // TODO: Implement messaging functionality
                },
                tooltip: 'Message Owner',
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              equipment.name,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              equipment.model,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                            ),
                             const SizedBox(height: 8),
                            Text(
                              '৳${equipment.price['day']}/day', // Assuming daily price
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 24),
                            const SizedBox(width: 5),
                            Text(
                              equipment.rating.toString(),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),

                    // Specifications
                    _buildSectionTitle(context, 'Details'),
                    _buildSpecificationRow('HP', '${equipment.hp} HP'),
                    _buildSpecificationRow('Model Year', equipment.modelYear.toString()),
                    _buildSpecificationRow('Fuel Type', equipment.fuelType),
                    const SizedBox(height: 20),
                    const Divider(),

                    // Description
                    _buildSectionTitle(context, 'Description'),
                    Text(
                      equipment.description,
                      style: const TextStyle(height: 1.5, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),

                    // Terms and Conditions
                    _buildSectionTitle(context, 'Terms and Conditions'),
                    Text(
                      equipment.terms,
                      style: const TextStyle(height: 1.5, fontSize: 16),
                    ),

                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingScreen(equipment: equipment),
                ),
              );
            },
            child: const Text('Book Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSpecificationRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
