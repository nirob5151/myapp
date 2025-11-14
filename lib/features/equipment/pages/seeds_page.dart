import 'package:flutter/material.dart';
import 'package:myapp/features/equipment/data/dummy_equipment.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:go_router/go_router.dart';

class SeedsPage extends StatefulWidget {
  const SeedsPage({super.key});

  @override
  State<SeedsPage> createState() => _SeedsPageState();
}

class _SeedsPageState extends State<SeedsPage> {
  String? _selectedCategory = 'All';
  String? _selectedCountry = 'All';
  String? _selectedDivision = 'All';

  @override
  Widget build(BuildContext context) {
    final List<Equipment> seeds = allDummyEquipment.where((e) => e.category == 'Seeds').toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF3B873E),
            title: const Text('Seeds for Sale', style: TextStyle(color: Colors.white)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.go('/'),
            ),
            pinned: true,
            floating: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search seeds...',
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDropdown('Category', _selectedCategory, ['All', 'Vegetables', 'Grains'], (val) {
                          setState(() => _selectedCategory = val);
                        }),
                        _buildDropdown('Country', _selectedCountry, ['All', 'Ireland'], (val) {
                          setState(() => _selectedCountry = val);
                        }),
                        _buildDropdown('Division', _selectedDivision, ['All', 'Munster', 'Leinster'], (val) {
                          setState(() => _selectedDivision = val);
                        }),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final seed = seeds[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Image.network(
                      seed.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.eco, size: 50, color: Colors.grey),
                    ),
                    title: Text(seed.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '€${seed.price}/bag',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3B873E)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          seed.isAvailable ? 'In Stock' : 'Out of Stock',
                          style: TextStyle(
                            color: seed.isAvailable ? const Color(0xFF3B873E) : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => context.go('/equipment/${seed.id}'),
                  ),
                );
              },
              childCount: seeds.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String hint, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1B5E20),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            hint: Text(hint, style: const TextStyle(color: Colors.white70)),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: onChanged,
            style: const TextStyle(color: Colors.white),
            dropdownColor: Colors.white,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
