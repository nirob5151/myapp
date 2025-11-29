
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/booking.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createBooking(Booking booking) async {
    await _firestore.collection('bookings').doc(booking.id).set(booking.toMap());
  }

  Future<Booking?> getBooking(String id) async {
    final doc = await _firestore.collection('bookings').doc(id).get();
    if (doc.exists) {
      return Booking.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateBooking(Booking booking) async {
    await _firestore.collection('bookings').doc(booking.id).update(booking.toMap());
  }

  Future<void> deleteBooking(String id) async {
    await _firestore.collection('bookings').doc(id).delete();
  }

  Stream<List<Booking>> getBookingsForFarmer(String farmerId) {
    return _firestore
        .collection('bookings')
        .where('farmerId', isEqualTo: farmerId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Booking.fromMap(doc.data())).toList());
  }

  Stream<List<Booking>> getBookingsForOwner(String ownerId) {
    return _firestore
        .collection('bookings')
        .where('ownerId', isEqualTo: ownerId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Booking.fromMap(doc.data())).toList());
  }
}
