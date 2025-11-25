import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'categories';

  Future<void> seedCategories() async {
    final categories = [
      Category(
        id: '',
        name: 'Tractor',
        imageUrl: 'https://loremflickr.com/200/300/tractor',
        icon: Icons.agriculture_outlined,
      ),
      Category(
        id: '',
        name: 'Harvester',
        imageUrl: 'https://loremflickr.com/200/300/harvester',
        icon: Icons.agriculture_sharp,
      ),
      Category(
        id: '',
        name: 'Seeds',
        imageUrl: 'https://loremflickr.com/200/300/seeds',
        icon: Icons.eco_outlined,
      ),
      Category(
        id: '',
        name: 'Water Pump',
        imageUrl: 'https://loremflickr.com/200/300/water_pump',
        icon: Icons.water_damage_outlined,
      ),
      Category(
        id: '',
        name: 'Sprayer',
        imageUrl: 'https://loremflickr.com/200/300/sprayer',
        icon: Icons.shower_outlined,
      ),
      Category(
        id: '',
        name: 'Tools',
        imageUrl: 'https://loremflickr.com/200/300/tools',
        icon: Icons.build_outlined,
      ),
    ];

    final collection = _firestore.collection(_collectionPath);
    final snapshot = await collection.get();

    if (snapshot.docs.isEmpty) {
      for (final category in categories) {
        await collection.add(category.toJson());
      }
    }
  }

  Stream<List<Category>> getCategories() {
    return _firestore.collection(_collectionPath).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Category.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<Category?> getCategory(String id) async {
    final doc = await _firestore.collection(_collectionPath).doc(id).get();
    if (doc.exists) {
      return Category.fromJson(doc.data()!, doc.id);
    }
    return null;
  }
}
