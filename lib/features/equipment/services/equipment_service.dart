import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/equipment/models/equipment.dart';

class EquipmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get a stream of equipment
  Stream<List<Equipment>> getEquipment() {
    return _firestore.collection('equipment').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Equipment(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
          imageUrl: data['imageUrl'] ?? '',
          ownerId: data['ownerId'] ?? '',
          isAvailable: data['isAvailable'] ?? true,
          availableDates: (data['availableDates'] as List<dynamic>? ?? []).map((e) => (e as Timestamp).toDate()).toList(),
        );
      }).toList();
    });
  }

  // Get a single piece of equipment by ID
  Future<Equipment?> getEquipmentById(String id) async {
    final doc = await _firestore.collection('equipment').doc(id).get();
    if (doc.exists) {
      final data = doc.data()!;
      return Equipment(
        id: doc.id,
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        imageUrl: data['imageUrl'] ?? '',
        ownerId: data['ownerId'] ?? '',
        isAvailable: data['isAvailable'] ?? true,
        availableDates: (data['availableDates'] as List<dynamic>? ?? []).map((e) => (e as Timestamp).toDate()).toList(),
      );
    }
    return null;
  }

  // Add a new piece of equipment
  Future<void> addEquipment(Equipment equipment) {
    return _firestore.collection('equipment').add({
      'name': equipment.name,
      'description': equipment.description,
      'price': equipment.price,
      'imageUrl': equipment.imageUrl,
      'ownerId': equipment.ownerId,
      'isAvailable': equipment.isAvailable,
      'availableDates': equipment.availableDates.map((e) => Timestamp.fromDate(e)).toList(),
    });
  }

  // Update an existing piece of equipment
  Future<void> updateEquipment(Equipment equipment) {
    return _firestore.collection('equipment').doc(equipment.id).update({
      'name': equipment.name,
      'description': equipment.description,
      'price': equipment.price,
      'imageUrl': equipment.imageUrl,
      'ownerId': equipment.ownerId,
      'isAvailable': equipment.isAvailable,
      'availableDates': equipment.availableDates.map((e) => Timestamp.fromDate(e)).toList(),
    });
  }

  // Delete a piece of equipment
  Future<void> deleteEquipment(String id) {
    return _firestore.collection('equipment').doc(id).delete();
  }
}
