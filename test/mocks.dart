
import 'package:flutter/material.dart';
import 'package:myapp/features/home/models/category.dart';
import 'package:myapp/features/home/services/category_service.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';

class MockCategoryService implements CategoryService {
  @override
  Future<List<Category>> getCategories() async {
    return [
      Category(label: 'Tractors', icon: Icons.agriculture, route: '/tractors'),
      Category(label: 'Harvesters', icon: Icons.grain, route: '/harvesters'),
      Category(label: 'Pumps', icon: Icons.water, route: '/pumps'),
    ];
  }
}

class MockEquipmentService implements EquipmentService {
  @override
  Stream<List<Equipment>> getEquipment() {
    return Stream.value([]);
  }

  @override
  Future<void> addEquipment(Equipment equipment) {
    return Future.value();
  }

  @override
  Future<void> deleteEquipment(String id) {
    return Future.value();
  }

  @override
  Future<Equipment?> getEquipmentById(String id) {
    return Future.value(null);
  }

  @override
  Future<void> updateEquipment(Equipment equipment) {
    return Future.value();
  }
}
