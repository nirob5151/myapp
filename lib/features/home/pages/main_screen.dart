import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on index
    switch (index) {
      case 0:
        // Home - already here
        break;
      case 1:
        // Equipment - can navigate to a general equipment page or first category
        context.go('/tractors');
        break;
      case 2:
        // Live Chat - Placeholder
        break;
      case 3:
        // Profile - Placeholder
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF3B873E),
            expandedHeight: 140.0, // Adjusted height
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Farmer Dashboard',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'tractors, harvesters, pumps...',
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    children: [
                      _buildCategoryCard(context, 'Tractors', Icons.agriculture, () => context.go('/tractors')), 
                      _buildCategoryCard(context, 'Harvesters', Icons.content_cut, () => context.go('/harvesters')), 
                      _buildCategoryCard(context, 'Pumps', Icons.water_drop, () => context.go('/pumps')),
                      _buildCategoryCard(context, 'Seeds', Icons.eco, () => context.go('/seeds')), 
                      _buildCategoryCard(context, 'Transport Vehicles', Icons.local_shipping, () => context.go('/transport-vehicles')), 
                      _buildCategoryCard(context, 'More', Icons.more_horiz, () {}),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Featured Ads',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                     height: 180, // Increased height for better look
                     child: ListView(
                       scrollDirection: Axis.horizontal,
                       children: [
                         _buildFeaturedAdCard(context, 'Tractor for Rent', 'https://www.deere.co.uk/assets/images/region-2/products/tractors/6-series/6r-250/6r_250_r4d084079_large.jpg'),
                         _buildFeaturedAdCard(context, 'Harvester for Rent', 'https://www.deere.co.uk/assets/images/region-2/products/combines/s-series/s700/s790_r4d032220_large.jpg'),
                       ],
                     ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF3B873E),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Rentals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Live Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40.0, color: const Color(0xFF3B873E)),
            const SizedBox(height: 8.0),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

   Widget _buildFeaturedAdCard(BuildContext context, String title, String imageUrl) {
    return Card(
      elevation: 2.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                  const SizedBox(height: 4.0),
                  Text('Starting from \$100/day', style: TextStyle(color: Colors.grey[600], fontSize: 14.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
