
import 'package:flutter/material.dart';
import 'package:myapp/features/booking/booking_screen.dart';
import 'package:myapp/features/chat/chat_screen.dart';
import 'package:myapp/models/equipment.dart';

class EquipmentDetailsScreen extends StatelessWidget {
  final Equipment equipment;

  const EquipmentDetailsScreen({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(equipment.name),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              equipment.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    equipment.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    equipment.price,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Specifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Power: 50 HP'),
                  const Text('Model: 2023'),
                  const Text('Fuel Type: Diesel'),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Owner',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('John Doe'),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(equipment.location),
                  const SizedBox(height: 16),
                  // Placeholder for map
                  Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('Map Placeholder')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingScreen(equipment: equipment),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Request Booking', style: TextStyle(color: Colors.white)),
              ),
              IconButton(
                icon: const Icon(Icons.chat),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(ownerId: equipment.ownerId, ownerName: 'John Doe'),
                    ),
                  );
                },
                tooltip: 'Chat with Owner',
              ),
              IconButton(
                icon: const Icon(Icons.call),
                onPressed: () {},
                tooltip: 'Call Owner',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
