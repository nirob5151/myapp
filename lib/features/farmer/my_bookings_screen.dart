
import 'package:flutter/material.dart';
import 'package:myapp/features/equipment/booking_service.dart';
import 'package:myapp/models/booking.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final BookingService _bookingService = BookingService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: Text('Please log in to see your bookings.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: StreamBuilder<List<Booking>>(
        stream: _bookingService.getBookingsForFarmer(currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final bookings = snapshot.data ?? [];
          if (bookings.isEmpty) {
            return const Center(child: Text('You have no bookings yet.'));
          }

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('Booking ID: ${booking.id}'), // You might want to show equipment name instead
                  subtitle: Text('Status: ${booking.status.toString().split('.').last}'),
                  trailing: Text('৳${booking.totalPrice.toStringAsFixed(2)}'),
                  onTap: () {
                    // Navigate to booking details screen
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
