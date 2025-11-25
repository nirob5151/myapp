import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/category.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Category>> getCategories() {
    return _firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Category.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }
}
