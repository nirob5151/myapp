
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
        name: 'Sonalika 750',
        model: 'DI 745 III',
        imageUrls: ['https://loremflickr.com/320/240/tractor?random=1'],
        price: {'day': 500},
        availability: 'Available',
        location: 'Dhaka',
        ownerId: 'owner1',
        rating: 4.5,
        hp: 50,
        modelYear: 2021,
        fuelType: 'Diesel',
        description: 'A powerful and reliable tractor for all your farming needs.',
        terms: 'Standard rental terms apply.',
        category: 'Tractors',
      ),
      Equipment(
        name: 'Tractor for Rent',
        model: 'DI 745 III',
        imageUrls: ['https://loremflickr.com/320/240/tractor?random=5'],
        price: {'day': 400},
        availability: 'Available',
        location: 'Dhaka',
        ownerId: 'owner1',
        rating: 4.5,
        hp: 50,
        modelYear: 2021,
        fuelType: 'Diesel',
        description: 'A powerful and reliable tractor for all your farming needs.',
        terms: 'Standard rental terms apply.',
        category: 'Tractors',
      ),
      Equipment(
        name: 'New Holland T5',
        model: 'DI 745 III',
        imageUrls: ['https://loremflickr.com/320/240/tractor?random=6'],
        price: {'day': 300},
        availability: 'Available',
        location: 'Dhaka',
        ownerId: 'owner1',
        rating: 4.5,
        hp: 50,
        modelYear: 2021,
        fuelType: 'Diesel',
        description: 'A powerful and reliable tractor for all your farming needs.',
        terms: 'Standard rental terms apply.',
        category: 'Tractors',
      ),
      Equipment(
        name: 'Massey Ferguson',
        model: 'DI 745 III',
        imageUrls: ['https://loremflickr.com/320/240/tractor?random=7'],
        price: {'day': 600},
        availability: 'Available',
        location: 'Dhaka',
        ownerId: 'owner1',
        rating: 4.5,
        hp: 50,
        modelYear: 2021,
        fuelType: 'Diesel',
        description: 'A powerful and reliable tractor for all your farming needs.',
        terms: 'Standard rental terms apply.',
        category: 'Tractors',
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
        category: 'Sprayers',
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
        category: 'Harvesters',
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
        category: 'Planters',
      ),
    ];

    final List<Equipment> filteredList = equipmentList
        .where((eq) => eq.category.toLowerCase() == categoryName.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search $categoryName',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: 'Category',
                  items: <String>['Category', 'Tractors', 'Harvesters']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                ),
                DropdownButton<String>(
                  value: 'Country',
                  items: <String>['Country', 'Bangladesh', 'India']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                ),
                DropdownButton<String>(
                  value: 'Division',
                  items: <String>['Division', 'Dhaka', 'Chittagong']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final equipment = filteredList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.equipmentDetail,
                      arguments: equipment,
                    );
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              equipment.imageUrls.first,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tractor for Rent - ${equipment.name}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '৳${equipment.price['day']}/day',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  equipment.availability,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: equipment.availability == 'Available'
                                        ? Colors.green
                                        : Colors.red,
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
        ],
      ),
    );
  }
}
