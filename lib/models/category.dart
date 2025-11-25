class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json, String id) {
    return Category(
      id: id,
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
