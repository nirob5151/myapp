import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String? country;
  final String? division;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.country,
    this.division,
  });

  factory UserModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snap.id,
      name: snapshot['name'],
      email: snapshot['email'],
      role: snapshot['role'],
      country: snapshot['country'],
      division: snapshot['division'],
    );
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? role,
    String? country,
    String? division,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      country: country ?? this.country,
      division: division ?? this.division,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'division': division,
    };
  }
}
