import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/rentals/repositories/rental_repository.dart';
import 'package:myapp/features/equipment/models/equipment.dart';

class MyRentalsPage extends StatefulWidget {
  const MyRentalsPage({super.key});

  @override
  State<MyRentalsPage> createState() => _MyRentalsPageState();
}

class _MyRentalsPageState extends State<MyRentalsPage> {
  final RentalRepository _rentalRepository = RentalRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rentals'),
        backgroundColor: const Color(0xFF00522E),
      ),
      body: FutureBuilder<List<Equipment>>(
        future: _rentalRepository.getRentedItems('mock_user_id'), // Pass a mock user ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('You have no rented items.'));
          }

          final rentedItems = snapshot.data!;

          return ListView.builder(
            itemCount: rentedItems.length,
            itemBuilder: (context, index) {
              final item = rentedItems[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(
                    item.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.name),
                  subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}/day'),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set the current index for the Rentals page
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              // Already on the MyRentalsPage
              break;
            case 2:
              // Add navigation to Live Chat page
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Rentals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Live Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color(0xFF00522E),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
