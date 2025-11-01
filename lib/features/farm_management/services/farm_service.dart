import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/farm_management/models/farm.dart';
import 'package:myapp/features/farm_management/models/crop.dart';

class FarmService {
  final CollectionReference _farmCollection = FirebaseFirestore.instance.collection('farms');
  final CollectionReference _cropCollection = FirebaseFirestore.instance.collection('crops');

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

  Future<void> addCrop(Crop crop) {
    return _cropCollection.add(crop.toJson());
  }

  Stream<List<Crop>> getCrops(String farmId) {
    return _cropCollection
        .where('farmId', isEqualTo: farmId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Crop.fromJson(data..['id'] = doc.id);
      }).toList();
    });
  }
}
