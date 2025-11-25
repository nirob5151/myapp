import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/models/equipment.dart';

class EquipmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'equipment';

  Future<void> addEquipment(Equipment equipment) async {
    if (equipment.imageUrl.isEmpty) {
      equipment = Equipment(
        id: equipment.id,
        name: equipment.name,
        description: equipment.description,
        rentalPrice: equipment.rentalPrice,
        ownerId: equipment.ownerId,
        categoryId: equipment.categoryId,
        imageUrl: 'https://loremflickr.com/200/300/${equipment.name}',
        isAvailable: equipment.isAvailable,
      );
    }
    await _firestore.collection(_collectionPath).add(equipment.toJson());
  }

  Stream<List<Equipment>> getOwnerEquipment() {
    final String ownerId = FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection(_collectionPath)
        .where('ownerId', isEqualTo: ownerId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Equipment.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  Stream<List<Equipment>> getAllEquipment() {
    return _firestore.collection(_collectionPath).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Equipment.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  Stream<List<Equipment>> getEquipmentByCategory(String categoryId) {
    return _firestore
        .collection(_collectionPath)
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Equipment.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> seedEquipment() async {
    final equipment = [
      Equipment(
        id: '',
        name: 'Tractor',
        description: 'A powerful tractor for all your farming needs.',
        rentalPrice: 5000,
        ownerId: 'dummy_owner_id',
        categoryId: 'tractor_category_id', // Replace with a real category ID
        imageUrl: 'https://loremflickr.com/200/300/tractor',
        isAvailable: true,
      ),
      Equipment(
        id: '',
        name: 'Harvester',
        description: 'A powerful harvester for all your farming needs.',
        rentalPrice: 10000,
        ownerId: 'dummy_owner_id',
        categoryId: 'harvester_category_id', // Replace with a real category ID
        imageUrl: 'https://loremflickr.com/200/300/harvester',
        isAvailable: true,
      ),
      Equipment(
        id: '',
        name: 'Seeds',
        description: 'High-quality seeds for a bountiful harvest.',
        rentalPrice: 500,
        ownerId: 'dummy_owner_id',
        categoryId: 'seeds_category_id', // Replace with a real category ID
        imageUrl: 'https://loremflickr.com/200/300/seeds',
        isAvailable: true,
      ),
      Equipment(
        id: '',
        name: 'Water Pump',
        description: 'A reliable water pump for your irrigation needs.',
        rentalPrice: 1000,
        ownerId: 'dummy_owner_id',
        categoryId: 'water_pump_category_id', // Replace with a real category ID
        imageUrl: 'https://loremflickr.com/200/300/water_pump',
        isAvailable: true,
      ),
      Equipment(
        id: '',
        name: 'Sprayer',
        description: 'A high-quality sprayer for your crops.',
        rentalPrice: 700,
        ownerId: 'dummy_owner_id',
        categoryId: 'sprayer_category_id', // Replace with a real category ID
        imageUrl: 'https://loremflickr.com/200/300/sprayer',
        isAvailable: true,
      ),
      Equipment(
        id: '',
        name: 'Tools',
        description: 'A set of essential farming tools.',
        rentalPrice: 300,
        ownerId: 'dummy_owner_id',
        categoryId: 'tools_category_id', // Replace with a real category ID
        imageUrl: 'https://loremflickr.com/200/300/tools',
        isAvailable: true,
      ),
    ];

    final collection = _firestore.collection(_collectionPath);
    final snapshot = await collection.get();

    if (snapshot.docs.isEmpty) {
      for (final item in equipment) {
        await collection.add(item.toJson());
      }
    }
  }
}
