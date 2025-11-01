import 'package:cloud_firestore/cloud_firestore.dart';

class Farm {
  final String? id;
  final String name;
  final String location;
  final String ownerId;
  final List<String> crops;

  Farm({
    this.id,
    required this.name,
    required this.location,
    required this.ownerId,
    this.crops = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'ownerId': ownerId,
      'crops': crops,
    };
  }

  factory Farm.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Farm(
      id: doc.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      ownerId: data['ownerId'] ?? '',
      crops: List<String>.from(data['crops'] ?? []),
    );
  }
}
