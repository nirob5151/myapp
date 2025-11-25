
import 'package:flutter/material.dart';
import 'package:myapp/features/equipment/equipment_details_screen.dart';
import 'package:myapp/models/equipment.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;

  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Dummy data for equipment
    final List<Equipment> equipmentList = [
      Equipment(
        name: 'Sonalika Tractor',
        imageUrl: 'https://loremflickr.com/320/240/tractor',
        price: '1200 BDT/day',
        availability: 'Available',
        location: 'Dhaka',
        ownerId: 'owner1',
      ),
      Equipment(
        name: 'Mahindra Sprayer',
        imageUrl: 'https://loremflickr.com/320/240/sprayer',
        price: '800 BDT/day',
        availability: 'Not Available',
        location: 'Chittagong',
        ownerId: 'owner2',
      ),
      Equipment(
        name: 'Kubota Harvester',
        imageUrl: 'https://loremflickr.com/320/240/harvester',
        price: '2500 BDT/day',
        availability: 'Available',
        location: 'Rajshahi',
        ownerId: 'owner3',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.green[800],
      ),
      body: ListView.builder(
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          final equipment = equipmentList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EquipmentDetailsScreen(equipment: equipment),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Image.network(
                      equipment.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            equipment.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            equipment.price,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                equipment.availability == 'Available'
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: equipment.availability == 'Available'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Text(equipment.availability),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(equipment.location),
                            ],
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
    );
  }
}
