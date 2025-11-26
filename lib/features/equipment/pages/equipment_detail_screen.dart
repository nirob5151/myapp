import 'package:flutter/material.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:go_router/go_router.dart';

class EquipmentDetailScreen extends StatelessWidget {
  final String equipmentId;

  const EquipmentDetailScreen({super.key, required this.equipmentId});

  @override
  Widget build(BuildContext context) {
    // This is dummy data. In a real app, you would fetch this from a service based on the equipmentId.
    final Equipment equipment = Equipment(
      id: equipmentId,
      name: 'Tractor for Rent - Sonalika 750',
      price: 500,
      imageUrls: ['https://upload.wikimedia.org/wikipedia/commons/3/39/Sonalika_DI_750_III_tractor.jpg'],
      ownerId: 'user123',
      isAvailable: true,
      availableDates: [DateTime.now(), DateTime.now().add(const Duration(days: 1))],
      category: 'Tractors',
      country: 'Ireland',
      division: 'Leinster',
      description: 'Paralyess .65 HF Bleeid adgine Hysto use thing sucwith more',
      rentalPrice: 500,
      location: 'Dublin',
      availability: 'Available',
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20), // Dark green color
        title: const Text('Equipment Details', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_a_photo, color: Colors.white),
                label: const Text('Add Photos', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32), // Slightly lighter green
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                elevation: 4.0,
                child: Image.network(
                  equipment.imageUrls.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.agriculture, size: 150, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                equipment.name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                '€${equipment.price.toStringAsFixed(0)}/day',
                style: const TextStyle(fontSize: 20, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('Availability', style: TextStyle(fontSize: 16, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                equipment.description,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.phone, color: Colors.white),
                      label: const Text('Book', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 1, height: 48, color: Colors.white),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.phone_in_talk, color: Colors.white),
                      label: const Text('Sap.', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.message_outlined, color: Color(0xFF2E7D32)),
                label: const Text('Cail / Message', style: TextStyle(color: Color(0xFF2E7D32))),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF2E7D32)),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
