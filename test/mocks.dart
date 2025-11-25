
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Stream<List<Equipment>> getEquipmentByOwner(String ownerId) {
    return Stream.value([]);
  }

  @override
  Future<DocumentReference> addEquipment(Equipment equipment) async {
    // This is a mock, so we don't need a real implementation.
    // We can throw an error if it's ever called in a test.
    throw UnimplementedError('addEquipment is not implemented in mock');
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
