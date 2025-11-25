import 'package:flutter/material.dart';
import 'package:myapp/models/equipment.dart';

class OwnerEquipmentCard extends StatelessWidget {
  final Equipment equipment;

  const OwnerEquipmentCard({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(equipment.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            Text(equipment.description),
            const SizedBox(height: 8.0),
            Text('\$${equipment.rentalPrice.toStringAsFixed(2)} per day'),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // TODO: Implement edit functionality
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // TODO: Implement delete functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
