
import 'package:cloud_firestore/cloud_firestore.dart';

class Ad {
  final String name;
  final String price;
  final String status;
  final String imageUrl;

  Ad({
    required this.name,
    required this.price,
    required this.status,
    required this.imageUrl,
  });

  factory Ad.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Ad(
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      status: data['status'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}

class AdService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Ad>> getFeaturedAds() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('featuredAds').get();
      return snapshot.docs.map((doc) => Ad.fromFirestore(doc)).toList();
    } catch (e) {
      // In a real app, you'd want to log this error
      print('Error fetching featured ads: $e');
      return [];
    }
  }
}
