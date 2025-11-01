import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/equipment/models/equipment.dart';

class EquipmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _equipmentCollection = FirebaseFirestore.instance.collection('equipment');

  Stream<List<Equipment>> getEquipment() {
    return _equipmentCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Equipment.fromFirestore(doc)).toList();
    });
  }

  Future<void> addEquipment(Equipment equipment) {
    return _equipmentCollection.add(equipment.toFirestore());
  }

  Future<void> updateEquipment(Equipment equipment) {
    return _equipmentCollection.doc(equipment.id).update(equipment.toFirestore());
  }

  Future<void> deleteEquipment(String equipmentId) {
    return _equipmentCollection.doc(equipmentId).delete();
  }
}
