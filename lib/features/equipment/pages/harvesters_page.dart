import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/features/authentication/services/auth_service.dart';
import 'package:myapp/features/equipment/helpers/currency_helper.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/location_service.dart';
import 'package:provider/provider.dart';

class HarvestersPage extends StatefulWidget {
  const HarvestersPage({super.key});

  @override
  State<HarvestersPage> createState() => _HarvestersPageState();
}

class _HarvestersPageState extends State<HarvestersPage> {
  String? _selectedCategory;
  String? _selectedCountry;
  String? _selectedDivision;
  final TextEditingController _searchController = TextEditingController();

  final LocationService _locationService = LocationService();
  late List<String> _countries;
  late List<String> _divisions;

  final List<Equipment> _allEquipment = [
    Equipment(
        id: '5',
        name: 'Harvester for Rent - John Deere S700',
        description: 'A powerful and versatile harvester.',
        price: 1200,
        imageUrl: 'https://www.deere.co.uk/assets/images/region-2/products/combines/s-series/s700/s790_r4d032220_large.jpg',
        ownerId: 'dummy_owner',
        isAvailable: true,
        availableDates: [],
        category: 'John Deere',
        country: 'Bangladesh',
        division: 'Dhaka',
      ),
      Equipment(
        id: '6',
        name: 'Harvester for Rent - Claas Lexion 8900',
        description: 'High-performance harvester with a comfortable cab.',
        price: 1500,
        imageUrl: 'https://www.claas.co.uk/blueprint/servlet/blob/1922580/a57b7d7857a2709e99a80529d434947c/lexion-8000-7000-stage-v-data.jpg',
        ownerId: 'dummy_owner',
        isAvailable: true,
        availableDates: [],
        category: 'Claas',
        country: 'Bangladesh',
        division: 'Chittagong',
      ),
  ];

  late List<Equipment> _filteredEquipment;

  @override
  void initState() {
    super.initState();
    _countries = _locationService.getCountries();
    _divisions = [];
    _filteredEquipment = _allEquipment;
    _searchController.addListener(_filterEquipment);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCountryChanged(String? newValue) {
    setState(() {
      _selectedCountry = newValue;
      _selectedDivision = null;
      _divisions = _locationService.getDivisions(newValue ?? '');
      _filterEquipment();
    });
  }

  void _filterEquipment() {
    final searchQuery = _searchController.text.toLowerCase();
    setState(() {
      _filteredEquipment = _allEquipment.where((equipment) {
        final nameMatch = equipment.name.toLowerCase().contains(searchQuery);
        final categoryMatch = _selectedCategory == null || _selectedCategory == 'All' || equipment.category == _selectedCategory;
        final countryMatch = _selectedCountry == null || equipment.country == _selectedCountry;
        final divisionMatch = _selectedDivision == null || equipment.division == _selectedDivision;
        return nameMatch && categoryMatch && countryMatch && divisionMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/home'),
        ),
        title: const Text('Harvester', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                color: const Color(0xFF1B5E20),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search harvester',
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
                            value: _selectedCategory,
                            items: <String>['All', 'John Deere', 'Claas'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(color: Colors.black)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategory = newValue;
                                _filterEquipment();
                              });
                            },
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
                             hint: const Text('Country', style: TextStyle(color: Colors.white, fontSize: 14)),
                            value: _selectedCountry,
                            items: _countries.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(color: Colors.black)),
                              );
                            }).toList(),
                            onChanged: _onCountryChanged,
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
                             hint: const Text('Division', style: TextStyle(color: Colors.white, fontSize: 14)),
                            value: _selectedDivision,
                            items: _divisions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(color: Colors.black)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedDivision = newValue;
                                _filterEquipment();
                              });
                            },
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
                child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _filteredEquipment.length,
                      itemBuilder: (context, index) {
                        final equipment = _filteredEquipment[index];
                        final currencySymbol = CurrencyHelper.getCurrencySymbol(equipment.country);
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
                                  child: Image.network(
                                    equipment.imageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.agriculture, size: 40, color: Colors.grey),
                                    ),
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
                                        '$currencySymbol${equipment.price.toStringAsFixed(0)}/day',
                                        style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.green[800],
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        equipment.isAvailable ? 'Availability' : 'Not Available',
                                        style: TextStyle(
                                          color: equipment.isAvailable ? Colors.grey : Colors.red,
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
                    )
              ),
            ],
          )
    );
  }
}
