import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;
  final IconData icon;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json, String id) {
    final iconData = json['icon'];
    return Category(
      id: id,
      name: json['name'],
      imageUrl: json['imageUrl'],
      icon: iconData != null
          ? IconData(iconData['codePoint'], fontFamily: iconData['fontFamily'])
          : Icons.agriculture, // Fallback icon
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'icon': {
        'codePoint': icon.codePoint,
        'fontFamily': icon.fontFamily,
      },
    };
  }
}
