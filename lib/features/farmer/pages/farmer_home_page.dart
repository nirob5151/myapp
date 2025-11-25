import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/auth/services/auth_service.dart';
import 'package:myapp/features/farmer/widgets/equipment_card.dart';
import 'package:myapp/features/owner/services/equipment_service.dart';
import 'package:myapp/main.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/models/equipment.dart';
import 'package:myapp/services/category_service.dart';
import 'package:provider/provider.dart';

class FarmerHomePage extends StatelessWidget {
  const FarmerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final categoryService = CategoryService();
    final equipmentService = EquipmentService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Dashboard'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              context.go('/login');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          StreamBuilder<List<Category>>(
            stream: categoryService.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No categories found.'));
              }

              final categories = snapshot.data!;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard(category: category);
                },
              );
            },
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Equipment',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          StreamBuilder<List<Equipment>>(
            stream: equipmentService.getAllEquipment(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No equipment found.'));
              }

              final equipmentList = snapshot.data!;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: equipmentList.length,
                itemBuilder: (context, index) {
                  final equipment = equipmentList[index];
                  return EquipmentCard(equipment: equipment);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(
            '/farmer_home/equipment_list/${category.id}?categoryName=${category.name}');
      },
      child: Card(
        elevation: 2.0,
        color: Colors.green.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 40, color: Colors.green),
            const SizedBox(height: 8.0),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
