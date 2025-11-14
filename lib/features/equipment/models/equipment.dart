import 'package:cloud_firestore/cloud_firestore.dart';

class Equipment {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String ownerId;
  final bool isAvailable;
  final List<DateTime> availableDates;
  final String category;
  final String country;
  final String division;

  Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.ownerId,
    required this.isAvailable,
    required this.availableDates,
    required this.category,
    required this.country,
    required this.division,
  });

  factory Equipment.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Equipment(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      ownerId: data['ownerId'] ?? '',
      isAvailable: data['isAvailable'] ?? false,
      availableDates: (data['availableDates'] as List<dynamic>? ?? []).map((timestamp) => (timestamp as Timestamp).toDate()).toList(),
      category: data['category'] ?? '',
      country: data['country'] ?? '',
      division: data['division'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'ownerId': ownerId,
      'isAvailable': isAvailable,
      'availableDates': availableDates.map((date) => Timestamp.fromDate(date)).toList(),
      'category': category,
      'country': country,
      'division': division,
    };
  }
}
