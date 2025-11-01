import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { farmer, owner }

class UserProfile {
  final String uid;
  final String email;
  final String displayName;
  final UserRole role;

  UserProfile({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
  });

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      uid: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      role: UserRole.values.firstWhere((e) => e.toString() == data['role'], orElse: () => UserRole.farmer),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'role': role.toString(),
    };
  }
}
