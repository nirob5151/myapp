import 'package:flutter/material.dart';
import 'package:myapp/features/equipment/models/equipment.dart';

class EquipmentCard extends StatelessWidget {
  final Equipment equipment;

  const EquipmentCard({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
              child: equipment.imageUrls.isNotEmpty
                  ? Image.network(
                      equipment.imageUrls.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.agriculture, size: 50, color: Colors.grey)),
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.agriculture, size: 50, color: Colors.grey),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  equipment.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6.0),
                Text(
                  '€${equipment.rentalPrice.toStringAsFixed(2)}/day',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    Icon(
                      equipment.isAvailable ? Icons.check_circle : Icons.cancel,
                      color: equipment.isAvailable ? Colors.green : Colors.red,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      equipment.isAvailable ? 'Available' : 'Unavailable',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: equipment.isAvailable ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
