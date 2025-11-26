
import 'package:flutter/material.dart';
import 'package:myapp/models/equipment.dart';
import 'package:myapp/utils/routes.dart';

class CategoryListingScreen extends StatelessWidget {
  final String categoryName;

  const CategoryListingScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
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
      Equipment(
        name: 'John Deere Planter',
        model: '1775NT',
        imageUrls: ['https://loremflickr.com/320/240/planter?random=4'],
        price: {'hour': 1500, 'day': 12000, 'week': 75000},
        availability: 'Available',
        location: 'Khulna',
        ownerId: 'owner4',
        rating: 4.7,
        hp: 200,
        modelYear: 2022,
        fuelType: 'Diesel',
        description: 'Precision planter for accurate seed placement.',
        terms: 'Calibration and setup included.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          final equipment = equipmentList[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.equipmentDetail,
                arguments: equipment,
              );
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      equipment.imageUrls.first,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          equipment.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          equipment.model,
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '৳${equipment.price['hour']}/hr',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 5),
                                Text(
                                  equipment.rating.toString(),
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                            const SizedBox(width: 5),
                            Text(
                              equipment.location,
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.booking,
                              arguments: equipment,
                            );
                          },
                          child: const Text('Book Now'),
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
