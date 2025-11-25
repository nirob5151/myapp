import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/models/equipment.dart';

class EquipmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'equipment';

  Future<void> addEquipment(Equipment equipment) async {
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
}
