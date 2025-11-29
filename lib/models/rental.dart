
import 'package:cloud_firestore/cloud_firestore.dart';

class Rental {
  final String equipmentId;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final double totalPrice;

  Rental({
    required this.equipmentId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
  });

  factory Rental.fromMap(Map<String, dynamic> data) {
    return Rental(
      equipmentId: data['equipmentId'] as String,
      userId: data['userId'] as String,
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      totalPrice: data['totalPrice'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'equipmentId': equipmentId,
      'userId': userId,
      'startDate': startDate,
      'endDate': endDate,
      'totalPrice': totalPrice,
    };
  }
}
