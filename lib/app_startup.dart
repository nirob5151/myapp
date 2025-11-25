import 'package:cloud_firestore/cloud_firestore.dart';

class AppStartup {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setupDummyData() async {
    await _addCategories();
    await _addEquipment();
  }

  Future<void> _addCategories() async {
    final categoriesCollection = _firestore.collection('categories');
    final snapshot = await categoriesCollection.limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      return; // Categories already exist
    }

    final categories = {
      'tractors': {
        'name': 'Tractors',
        'imageUrl':
            'https://plus.unsplash.com/premium_photo-1679933068259-3175d2b3ad57?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      'harvesters': {
        'name': 'Harvesters',
        'imageUrl':
            'https://images.unsplash.com/photo-1562309282-1df533d39f2d?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      'plows': {
        'name': 'Plows',
        'imageUrl':
            'https://images.unsplash.com/photo-1621237096019-373e4b752b54?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      'seeders': {
        'name': 'Seeders',
        'imageUrl':
            'https://images.unsplash.com/photo-1563514227843-7d97d1b3260b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
    };

    for (var entry in categories.entries) {
      await categoriesCollection.doc(entry.key).set(entry.value);
    }
  }

  Future<void> _addEquipment() async {
    final equipmentCollection = _firestore.collection('equipment');
    final snapshot = await equipmentCollection.limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      return; // Equipment already exists
    }

    final equipment = [
      {
        'name': 'John Deere 9R 640',
        'description': 'A powerful and versatile tractor.',
        'rentalPrice': 150.0,
        'ownerId': 'dummy_owner_1',
        'categoryId': 'tractors',
        'imageUrl':
            'https://plus.unsplash.com/premium_photo-1679933068259-3175d2b3ad57?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'name': 'Case IH Axial-Flow 9250',
        'description': 'A high-performance combine harvester.',
        'rentalPrice': 250.0,
        'ownerId': 'dummy_owner_2',
        'categoryId': 'harvesters',
        'imageUrl':
            'https://images.unsplash.com/photo-1562309282-1df533d39f2d?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'name': 'Kuhn Master 183',
        'description': 'A durable and efficient plow.',
        'rentalPrice': 50.0,
        'ownerId': 'dummy_owner_3',
        'categoryId': 'plows',
        'imageUrl':
            'https://images.unsplash.com/photo-1621237096019-373e4b752b54?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
      {
        'name': 'Horsch Pronto 6 AS',
        'description': 'A precise and reliable seeder.',
        'rentalPrice': 75.0,
        'ownerId': 'dummy_owner_4',
        'categoryId': 'seeders',
        'imageUrl':
            'https://images.unsplash.com/photo-1563514227843-7d97d1b3260b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      },
    ];

    for (var item in equipment) {
      await equipmentCollection.add(item);
    }
  }
}
