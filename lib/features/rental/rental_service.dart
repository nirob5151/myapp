
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/rental.dart';

class RentalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createRental(Rental rental) async {
    await _firestore.collection('rentals').add(rental.toMap());
  }

  Stream<List<Rental>> getRentalsForUser(String userId) {
    return _firestore
        .collection('rentals')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Rental.fromMap(doc.data())).toList());
  }
}
