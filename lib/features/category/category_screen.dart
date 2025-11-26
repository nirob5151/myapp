
import 'package:flutter/material.dart';
import 'package:myapp/features/equipment/equipment_details_screen.dart';
import 'package:myapp/models/equipment.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;

  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Dummy data for equipment, updated to the new model
    final List<Equipment> equipmentList = [
      Equipment(
        name: 'Sonalika Tractor',
        model: 'DI 745 III',
        imageUrls: ['https://loremflickr.com/320/240/tractor?random=1'],
        price: {'hour': 1000, 'day': 8000, 'week': 50000},
        availability: 'Available',
        location: 'Dhaka',
        ownerId: 'owner1',
        rating: 4.5,
        hp: 50,
        modelYear: 2021,
        fuelType: 'Diesel',
        description: 'A powerful and reliable tractor for all your farming needs.',
        terms: 'Standard rental terms apply.',
      ),
      Equipment(
        name: 'Mahindra Sprayer',
        model: 'M-SP1000',
        imageUrls: ['https://loremflickr.com/320/240/sprayer?random=2'],
        price: {'hour': 500, 'day': 3500, 'week': 20000},
        availability: 'Not Available',
        location: 'Chittagong',
        ownerId: 'owner2',
        rating: 4.2,
        hp: 15,
        modelYear: 2022,
        fuelType: 'Gasoline',
        description: 'Efficient and easy-to-use sprayer for pesticides and fertilizers.',
        terms: 'Handle with care. Renter is liable for damages.',
      ),
      Equipment(
        name: 'Kubota Harvester',
        model: 'PRO688Q',
        imageUrls: ['https://loremflickr.com/320/240/harvester?random=3'],
        price: {'hour': 2500, 'day': 20000, 'week': 120000},
        availability: 'Available',
        location: 'Rajshahi',
        ownerId: 'owner3',
        rating: 4.8,
        hp: 68,
        modelYear: 2023,
        fuelType: 'Diesel',
        description: 'High-performance harvester for quick and efficient crop cutting.',
        terms: 'Requires a trained operator.',
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
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Image.network(
                      equipment.imageUrls.first,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          equipment.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${equipment.price['day']?.toInt()} BDT/day',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (equipment.rating > 0)
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    equipment.rating.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey[600],
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              equipment.location,
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                            const Spacer(),
                             Icon(
                              equipment.availability == 'Available'
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: equipment.availability == 'Available'
                                  ? Colors.green
                                  : Colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              equipment.availability,
                              style: TextStyle(
                                color: equipment.availability == 'Available'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
