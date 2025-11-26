
class Equipment {
  final String name;
  final String model;
  final String category;
  final List<String> imageUrls;
  final Map<String, int> price; // e.g., {'hour': 500, 'day': 4000, 'week': 25000}
  final String availability;
  final String location;
  final String ownerId;
  final double rating;
  final int hp;
  final int modelYear;
  final String fuelType;
  final String description;
  final String terms;

  Equipment({
    required this.name,
    required this.model,
    required this.category,
    required this.imageUrls,
    required this.price,
    required this.availability,
    required this.location,
    required this.ownerId,
    this.rating = 0.0,
    required this.hp,
    required this.modelYear,
    required this.fuelType,
    required this.description,
    required this.terms,
  });
}
