import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';
import 'package:provider/provider.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final equipmentService = Provider.of<EquipmentService>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text('Equipment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            color: const Color(0xFF1B5E20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search equipment',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B5E20),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Category', style: TextStyle(color: Colors.white, fontSize: 14)),
                        items: <String>['Sonalika', 'New Holland', 'Massey Ferguson'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (_) {},
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: Colors.white,
                         icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B5E20),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Location', style: TextStyle(color: Colors.white, fontSize: 14)),
                        items: <String>['Location A', 'Location B', 'Location C'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (_) {},
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: Colors.white,
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Equipment>>(
              stream: equipmentService.getEquipment(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No equipment available.'),
                  );
                }

                final equipmentList = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: equipmentList.length,
                  itemBuilder: (context, index) {
                    final equipment = equipmentList[index];
                    return Card(
                      elevation: 2.0,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: equipment.imageUrls.isNotEmpty
                                  ? Image.network(
                                      equipment.imageUrls.first,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.agriculture, size: 40, color: Colors.grey),
                                      ),
                                    )
                                  : Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.agriculture, size: 40, color: Colors.grey),
                                    ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    equipment.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    '€${equipment.price.toStringAsFixed(0)}/day',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text(
                                    'Availability',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1B5E20),
        onPressed: () {
          context.go('/add-equipment');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
