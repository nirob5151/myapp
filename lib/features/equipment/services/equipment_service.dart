import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/equipment/models/equipment.dart';

class EquipmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get a stream of equipment
  Stream<List<Equipment>> getEquipment() {
    return _firestore.collection('equipment').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Equipment.fromSnap(doc)).toList();
    });
  }

  // Get a stream of equipment for a specific owner
  Stream<List<Equipment>> getEquipmentByOwner(String ownerId) {
    return _firestore
        .collection('equipment')
        .where('ownerId', isEqualTo: ownerId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Equipment.fromSnap(doc)).toList();
    });
  }

  // Get a single piece of equipment by ID
  Future<Equipment?> getEquipmentById(String id) async {
    final doc = await _firestore.collection('equipment').doc(id).get();
    if (doc.exists) {
      return Equipment.fromSnap(doc);
    }
    return null;
  }

  // Add a new piece of equipment
  Future<DocumentReference> addEquipment(Equipment equipment) {
    return _firestore.collection('equipment').add(equipment.toFirestore());
  }

  // Update an existing piece of equipment
  Future<void> updateEquipment(Equipment equipment) {
    return _firestore
        .collection('equipment')
        .doc(equipment.id)
        .update(equipment.toFirestore());
  }

  // Delete a piece of equipment
  Future<void> deleteEquipment(String id) {
    return _firestore.collection('equipment').doc(id).delete();
  }
}
