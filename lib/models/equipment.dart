class Equipment {
  final String id;
  final String name;
  final String description;
  final double rentalPrice;
  final String ownerId;
  final String imageUrl;

  Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.rentalPrice,
    required this.ownerId,
    this.imageUrl = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'rentalPrice': rentalPrice,
      'ownerId': ownerId,
      'imageUrl': imageUrl,
    };
  }

  factory Equipment.fromJson(Map<String, dynamic> json, String id) {
    return Equipment(
      id: id,
      name: json['name'],
      description: json['description'],
      rentalPrice: (json['rentalPrice'] ?? 0.0).toDouble(),
      ownerId: json['ownerId'],
      imageUrl: json['imageUrl'],
    );
  }
}
