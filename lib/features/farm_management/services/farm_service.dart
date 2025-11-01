import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/features/farm_management/models/farm.dart';

class FarmService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Farm>> getFarms() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection('farms')
        .where('ownerId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Farm.fromFirestore(doc)).toList();
    });
  }

  Future<void> addFarm(Farm farm) {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    final newFarm = farm.toJson();
    newFarm.update('ownerId', (value) => user.uid);

    return _firestore.collection('farms').add(newFarm);
  }
}
