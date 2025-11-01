import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/farm_management/models/farm.dart';

class FarmService {
  final CollectionReference _farmCollection = FirebaseFirestore.instance.collection('farms');

  Future<void> addFarm(Farm farm) {
    return _farmCollection.add(farm.toJson());
  }

  Stream<List<Farm>> getFarms(String ownerId) {
    return _farmCollection
        .where('ownerId', isEqualTo: ownerId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Farm.fromFirestore(doc)).toList();
    });
  }
}
