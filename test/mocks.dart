
import 'package:flutter/material.dart';
import 'package:myapp/features/home/models/category.dart';
import 'package:myapp/features/home/services/category_service.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';

class MockCategoryService implements CategoryService {
  @override
  Future<List<Category>> getCategories() async {
    return [
      Category(id: '1', label: 'Tractors', icon: Icons.agriculture, route: '/tractors'),
      Category(id: '2', label: 'Harvesters', icon: Icons.grain, route: '/harvesters'),
      Category(id: '3', label: 'Pumps', icon: Icons.water, route: '/pumps'),
    ];
  }
}

class MockEquipmentService implements EquipmentService {
  @override
  Stream<List<Equipment>> getEquipment() {
    return Stream.value([]);
  }
}
