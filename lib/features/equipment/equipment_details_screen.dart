
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
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(equipment.name, style: const TextStyle(shadows: [Shadow(blurRadius: 10)])),
              background: CarouselSlider(
                options: CarouselOptions(
                  height: 350.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                ),
                items: equipment.imageUrls.map((item) => Container(
                  child: Center(
                    child: Image.network(item, fit: BoxFit.cover, height: 350)
                  ),
                )).toList(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Options
                    _buildSectionTitle(context, 'Pricing'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPriceChip(context, 'Hour', equipment.price['hour'] ?? 0),
                        _buildPriceChip(context, 'Day', equipment.price['day'] ?? 0),
                        _buildPriceChip(context, 'Week', equipment.price['week'] ?? 0),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),

                    // Availability Calendar
                    _buildSectionTitle(context, 'Availability'),
                    // Placeholder for a calendar - a real implementation would use a package like table_calendar
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(child: Text('Availability Calendar Placeholder', style: TextStyle(color: Colors.grey))),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),

                    // Specifications
                    _buildSectionTitle(context, 'Specifications'),
                    _buildSpecificationRow('Model', equipment.model),
                    _buildSpecificationRow('Horsepower', '${equipment.hp} HP'),
                    _buildSpecificationRow('Model Year', equipment.modelYear.toString()),
                    _buildSpecificationRow('Fuel Type', equipment.fuelType),
                    const SizedBox(height: 20),
                    const Divider(),

                    // Owner Information
                    _buildSectionTitle(context, 'Owner Information'),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage('https://loremflickr.com/100/100/portrait?random=1'),
                        ),
                        title: const Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('Verified Owner'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline),
                              onPressed: () {
                                // TODO: Navigate to chat screen
                              },
                              tooltip: 'Chat with Owner',
                            ),
                            IconButton(
                              icon: const Icon(Icons.call_outlined),
                              onPressed: () {
                                // TODO: Initiate call
                              },
                              tooltip: 'Call Owner',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),

                    // Map Location
                    _buildSectionTitle(context, 'Location'),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: NetworkImage('https://loremflickr.com/600/400/map?random=1'), // Placeholder map image
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.location_on, color: Colors.red, size: 40)
                      ),
                    ),
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

                    // Terms and Policies
                    _buildSectionTitle(context, 'Terms and Policies'),
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
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingScreen(equipment: equipment),
                ),
              );
            },
            child: const Text('Request Booking'),
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
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPriceChip(BuildContext context, String label, double price) {
    return Chip(
      backgroundColor: Colors.green[100],
      avatar: Icon(Icons.timer_outlined, color: Colors.green[800]),
      label: Text(
        '${price.toInt()} BDT/$label',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green[900],
        ),
      ),
    );
  }

  Widget _buildSpecificationRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
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
