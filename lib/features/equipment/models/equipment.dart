class Equipment {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String ownerId;
  final bool isAvailable;
  final List<DateTime> availableDates;

  Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.ownerId,
    required this.isAvailable,
    required this.availableDates,
  });
}
