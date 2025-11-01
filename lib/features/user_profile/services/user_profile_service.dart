import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/user_profile/models/user_profile.dart';

class UserProfileService {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUserProfile({
    required String uid,
    required String email,
    required String displayName,
    required UserRole role,
  }) async {
    final userProfile = UserProfile(
      uid: uid,
      email: email,
      displayName: displayName,
      role: role,
    );
    await _userCollection.doc(uid).set(userProfile.toFirestore());
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    final doc = await _userCollection.doc(uid).get();
    if (doc.exists) {
      return UserProfile.fromFirestore(doc);
    }
    return null;
  }
}
