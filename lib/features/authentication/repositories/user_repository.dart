import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/authentication/models/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      return UserModel.fromSnap(doc);
    } catch (e) {
      return null;
    }
  }
}
