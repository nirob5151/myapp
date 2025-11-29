
class UserModel {
  final String uid;
  final String? name;
  final String email;
  final String? photoUrl;
  final String? userType; // 'farmer' or 'equipment_owner'

  UserModel({
    required this.uid,
    this.name,
    required this.email,
    this.photoUrl,
    this.userType,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] as String,
      name: data['name'] as String?,
      email: data['email'] as String,
      photoUrl: data['photoUrl'] as String?,
      userType: data['userType'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'userType': userType,
    };
  }
}
