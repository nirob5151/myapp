import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/authentication/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
