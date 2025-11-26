
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('featuredAds');

  final ads = [
    {
      'name': 'Sonalika Tractor',
      'price': '1200 BDT/day',
      'status': 'Available',
      'imageUrl': 'https://images.unsplash.com/photo-1625037424596-6815d398574a?q=80&w=2070&auto=format&fit=crop'
    },
    {
      'name': 'John Deere Harvester',
      'price': '1500 BDT/day',
      'status': 'Available',
      'imageUrl': 'https://images.unsplash.com/photo-1559269786-2f30b419875b?q=80&w=1974&auto=format&fit=crop'
    },
    {
      'name': 'Massey Ferguson Tractor',
      'price': '1300 BDT/day',
      'status': 'Unavailable',
      'imageUrl': 'https://images.unsplash.com/photo-1590522523035-866b8b0a9a4c?q=80&w=2070&auto=format&fit=crop'
    },
    {
      'name': 'Claas Combine Harvester',
      'price': '1800 BDT/day',
      'status': 'Available',
      'imageUrl': 'https://images.unsplash.com/photo-1623423447953-3b5b5b3ba3a4?q=80&w=1932&auto=format&fit=crop'
    },
  ];

  for (var ad in ads) {
    await collection.add(ad);
  }

  print('Successfully populated featuredAds collection!');
}
