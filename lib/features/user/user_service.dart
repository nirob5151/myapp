import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/authentication/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserModel?> getUserStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((snap) {
      if (snap.exists) {
        return UserModel.fromSnap(snap);
      }
      return null;
    });
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromSnap(doc);
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error getting user: $e');
    }
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).update(user.toJson());
    } catch (e) {
      // ignore: avoid_print
      print('Error updating user: $e');
      rethrow;
    }
  }
}
