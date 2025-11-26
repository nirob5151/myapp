
import 'package:flutter/material.dart';
import 'package:myapp/models/booking.dart';
import 'package:myapp/models/equipment.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy booking data
    final List<Booking> bookings = [
      Booking(
        id: '1',
        farmerId: 'user1',
        ownerId: 'owner1',
        equipment: Equipment(
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
        bookingDate: DateTime.now().subtract(const Duration(days: 10)),
        bookingTime: const TimeOfDay(hour: 10, minute: 0),
        duration: 8,
        location: 'Gazipur',
        status: BookingStatus.completed,
      ),
      Booking(
        id: '2',
        farmerId: 'user1',
        ownerId: 'owner2',
        equipment: Equipment(
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
        bookingDate: DateTime.now().add(const Duration(days: 2)),
        bookingTime: const TimeOfDay(hour: 14, minute: 30),
        duration: 4,
        location: 'Comilla',
        status: BookingStatus.accepted,
      ),
      Booking(
        id: '3',
        farmerId: 'user1',
        ownerId: 'owner3',
        equipment: Equipment(
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
        bookingDate: DateTime.now().add(const Duration(days: 5)),
        bookingTime: const TimeOfDay(hour: 9, minute: 0),
        duration: 12,
        location: 'Bogra',
        status: BookingStatus.pending,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            elevation: 3,
            child: ListTile(
              leading: Image.network(
                booking.equipment.imageUrls.first,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(booking.equipment.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${booking.bookingDate.day}/${booking.bookingDate.month}/${booking.bookingDate.year}'),
                  Text('Status: ${booking.status.toString().split('.').last}'),
                ],
              ),
              trailing: _buildStatusChip(booking.status),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusChip(BookingStatus status) {
    Color color;
    String label;
    switch (status) {
      case BookingStatus.pending:
        color = Colors.orange;
        label = 'Pending';
        break;
      case BookingStatus.accepted:
        color = Colors.blue;
        label = 'Accepted';
        break;
      case BookingStatus.rejected:
        color = Colors.red;
        label = 'Rejected';
        break;
      case BookingStatus.ongoing:
        color = Colors.purple;
        label = 'Ongoing';
        break;
      case BookingStatus.completed:
        color = Colors.green;
        label = 'Completed';
        break;
    }
    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }
}
