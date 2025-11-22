
import 'package:myapp/features/equipment/models/equipment.dart';

class RentalRepository {
  // Mock data for demonstration purposes
  final List<Equipment> _rentedItems = [
    Equipment(
      id: '1',
      name: 'John Deere 9R 640',
      description: 'A powerful and versatile tractor.',
      price: 250.0,
      imageUrl: 'https://www.deere.co.za/assets/images/region-4/products/tractors/row-crop-tractors/8r-series-tractor-r4g002231-large.png',
      ownerId: 'owner1',
      isAvailable: false,
      availableDates: [],
      category: 'Tractors',
      country: 'USA',
      division: 'Agriculture',
    ),
    Equipment(
      id: '2',
      name: 'Case IH Axial-Flow 9250',
      description: 'A high-capacity combine harvester.',
      price: 500.0,
      imageUrl: 'https://www.caseih.com/northamerica/en-us/PublishingImages/products/combines/axial-flow-250-series/21-235_background-1_N.jpg',
      ownerId: 'owner2',
      isAvailable: false,
      availableDates: [],
      category: 'Harvesters',
      country: 'USA',
      division: 'Agriculture',
    ),
  ];

  Future<List<Equipment>> getRentedItems(String userId) async {
    // In a real application, you would fetch this data from a backend based on the userId.
    // For now, we'll just return the mock data.
    return Future.delayed(const Duration(seconds: 1), () => _rentedItems);
  }
}
