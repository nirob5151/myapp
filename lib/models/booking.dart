
import 'package:flutter/material.dart';
import 'package:myapp/models/equipment.dart';

enum BookingStatus { pending, accepted, rejected, ongoing, completed }

class Booking {
  final String id;
  final String farmerId;
  final String ownerId;
  final Equipment equipment;
  final DateTime bookingDate;
  final TimeOfDay bookingTime;
  final int duration;
  final String location;
  final BookingStatus status;

  Booking({
    required this.id,
    required this.farmerId,
    required this.ownerId,
    required this.equipment,
    required this.bookingDate,
    required this.bookingTime,
    required this.duration,
    required this.location,
    this.status = BookingStatus.pending,
  });
}
