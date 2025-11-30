import 'package:cloud_firestore/cloud_firestore.dart';

class Equipment {
  final String id;
  final String name;
  final String description;
  final double rentalPrice;
  final List<String> imageUrls;
  final String ownerId;
  final bool isAvailable;
  final List<DateTime> availableDates;
  final String category;
  final String country;
  final String division;
  final String location;
  final String availability;
  final String name_lowercase;

  Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.rentalPrice,
    required this.imageUrls,
    required this.ownerId,
    required this.isAvailable,
    required this.availableDates,
    required this.category,
    required this.country,
    required this.division,
    required this.location,
    required this.availability,
    required this.name_lowercase,
  });

  factory Equipment.fromSnap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Equipment(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      rentalPrice: (data['rentalPrice'] ?? 0).toDouble(),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      ownerId: data['ownerId'] ?? '',
      isAvailable: data['isAvailable'] ?? false,
      availableDates: (data['availableDates'] as List<dynamic>? ?? [])
          .map((timestamp) => (timestamp as Timestamp).toDate())
          .toList(),
      category: data['category'] ?? '',
      country: data['country'] ?? '',
      division: data['division'] ?? '',
      location: data['location'] ?? '',
      availability: data['availability'] ?? '',
      name_lowercase: data['name_lowercase'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'rentalPrice': rentalPrice,
      'imageUrls': imageUrls,
      'ownerId': ownerId,
      'isAvailable': isAvailable,
      'availableDates':
          availableDates.map((date) => Timestamp.fromDate(date)).toList(),
      'category': category,
      'country': country,
      'division': division,
      'location': location,
      'availability': availability,
      'name_lowercase': name.toLowerCase(),
    };
  }

  Equipment copyWith({
    String? id,
    String? name,
    String? description,
    double? rentalPrice,
    List<String>? imageUrls,
    String? ownerId,
    bool? isAvailable,
    List<DateTime>? availableDates,
    String? category,
    String? country,
    String? division,
    String? location,
    String? availability,
    String? name_lowercase,
  }) {
    return Equipment(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rentalPrice: rentalPrice ?? this.rentalPrice,
      imageUrls: imageUrls ?? this.imageUrls,
      ownerId: ownerId ?? this.ownerId,
      isAvailable: isAvailable ?? this.isAvailable,
      availableDates: availableDates ?? this.availableDates,
      category: category ?? this.category,
      country: country ?? this.country,
      division: division ?? this.division,
      location: location ?? this.location,
      availability: availability ?? this.availability,
      name_lowercase: name_lowercase ?? this.name_lowercase,
    );
  }
}
