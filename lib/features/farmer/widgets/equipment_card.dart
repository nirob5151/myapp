import 'package:flutter/material.dart';
import 'package:myapp/models/equipment.dart';

class EquipmentCard extends StatelessWidget {
  final Equipment equipment;

  const EquipmentCard({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: equipment.imageUrl.isNotEmpty
                  ? Image.network(
                      equipment.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.agriculture, size: 50, color: Colors.grey),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  equipment.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${equipment.rentalPrice.toStringAsFixed(0)} BDT/day',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  equipment.isAvailable ? 'Available' : 'Unavailable',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: equipment.isAvailable ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
