
import 'package:flutter/material.dart';
import 'package:myapp/features/auth/login_screen.dart';
import 'package:myapp/features/chat/chat_screen.dart';
import 'package:myapp/features/chat/conversation_screen.dart';
import 'package:myapp/features/dashboard/farmer_dashboard.dart';
import 'package:myapp/features/equipment/booking_screen.dart';
import 'package:myapp/features/equipment/category_listing_screen.dart';
import 'package:myapp/features/equipment/equipment_detail_screen.dart';
import 'package:myapp/features/not_found/not_found_screen.dart';
import 'package:myapp/features/profile/booking_history_screen.dart';
import 'package:myapp/features/profile/profile_screen.dart';
import 'package:myapp/models/equipment.dart';

class AppRoutes {
  static const String login = '/login';
  static const String farmerDashboard = '/';
  static const String categoryListing = '/category-listing';
  static const String equipmentDetail = '/equipment-detail';
  static const String booking = '/booking';
  static const String profile = '/profile';
  static const String bookingHistory = '/booking-history';
  static const String chat = '/chat';
  static const String conversation = '/conversation';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case farmerDashboard:
        return MaterialPageRoute(builder: (_) => const FarmerDashboard());
      case categoryListing:
        final String categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CategoryListingScreen(categoryName: categoryName),
        );
      case equipmentDetail:
        final Equipment equipment = settings.arguments as Equipment;
        return MaterialPageRoute(
          builder: (_) => EquipmentDetailScreen(equipment: equipment),
        );
      case booking:
        final Equipment equipment = settings.arguments as Equipment;
        return MaterialPageRoute(
          builder: (_) => BookingScreen(equipment: equipment),
        );
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case bookingHistory:
        return MaterialPageRoute(builder: (_) => const BookingHistoryScreen());
      case chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case conversation:
        final String ownerName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ConversationScreen(ownerName: ownerName),
        );
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
