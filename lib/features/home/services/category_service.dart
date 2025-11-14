import 'package:flutter/material.dart';
import 'package:myapp/features/home/models/category.dart';

class CategoryService {
  Future<List<Category>> getCategories() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 1));

    return [
      Category(icon: Icons.agriculture, label: 'Tractors', route: '/tractors'),
      Category(icon: Icons.settings_applications, label: 'Harvesters', route: '/harvesters'),
      Category(icon: Icons.local_drink, label: 'Pumps', route: '/pumps'),
      Category(icon: Icons.devices_other, label: 'Accessories', route: '/accessories'),
      Category(icon: Icons.add_shopping_cart, label: 'Rentals', route: '/rentals'),
      Category(icon: Icons.more_horiz, label: 'More', route: '/more'),
    ];
  }
}
