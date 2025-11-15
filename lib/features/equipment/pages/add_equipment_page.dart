import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/features/authentication/services/auth_service.dart';
import 'package:myapp/features/equipment/models/equipment.dart';
import 'package:myapp/features/equipment/services/equipment_service.dart';
import 'package:myapp/features/equipment/services/location_service.dart';
import 'package:provider/provider.dart';

class AddEquipmentPage extends StatefulWidget {
  const AddEquipmentPage({super.key});

  @override
  State<AddEquipmentPage> createState() => _AddEquipmentPageState();
}

class _AddEquipmentPageState extends State<AddEquipmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  String? _selectedCountry;
  String? _selectedDivision;
  File? _image;

  final LocationService _locationService = LocationService();
  late List<String> _countries;
  late List<String> _divisions;

  @override
  void initState() {
    super.initState();
    _countries = _locationService.getCountries();
    _divisions = [];
  }

  void _onCountryChanged(String? newValue) {
    setState(() {
      _selectedCountry = newValue;
      _selectedDivision = null;
      _divisions = _locationService.getDivisions(newValue ?? '');
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('equipment_images')
        .child('${DateTime.now().toIso8601String()}.jpg');
    final uploadTask = storageRef.putFile(image);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> _seedData() async {
    final equipmentService =
        Provider.of<EquipmentService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    if (user != null) {
      final tractors = [
        Equipment(
          id: '',
          name: 'John Deere 8R 370',
          description: 'A powerful and versatile tractor for all your farming needs.',
          price: 250.00,
          imageUrl: 'https://www.deere.co.uk/assets/images/region-2/products/tractors/8r-series/8r-370/8r_370_r2d082779_large_3206e6402434b32a5384385e5893392a4582f346.jpg',
          ownerId: user.uid,
          isAvailable: true,
          availableDates: [DateTime.now()],
          category: 'Tractor',
          country: 'Bangladesh',
          division: 'Dhaka',
        ),
        Equipment(
          id: '',
          name: 'Case IH Magnum 380',
          description: 'High-performance tractor with a comfortable cab.',
          price: 275.00,
          imageUrl: 'https://assets.cnhindustrial.com/caseih/NAFTA/NAFTAASSETS/Products/Tractors/Magnum-Series/magnum-380/Magnum-380-Tractor-01.jpg',
          ownerId: user.uid,
          isAvailable: true,
          availableDates: [DateTime.now()],
          category: 'Tractor',
          country: 'Bangladesh',
          division: 'Chittagong',
        ),
        Equipment(
          id: '',
          name: 'New Holland T8',
          description: 'A reliable and efficient tractor for modern farming.',
          price: 260.00,
          imageUrl: 'https://agriculture.newholland.com/nar/en-us/PublishingImages/products/tractors-telehandlers/t8-genesis-plmi/gallery/2021-new-holland-t8-genesis-plmi-01.jpg',
          ownerId: user.uid,
          isAvailable: false,
          availableDates: [],
          category: 'Tractor',
          country: 'India',
          division: 'Punjab',
        ),
      ];

      for (final tractor in tractors) {
        await equipmentService.addEquipment(tractor);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tractor data seeded successfully!')),
        );
      }
    }
  }

  Future<void> _seedHarvesterData() async {
    final equipmentService =
        Provider.of<EquipmentService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    if (user != null) {
      final harvesters = [
        Equipment(
          id: '',
          name: 'John Deere S700',
          description: 'Advanced combine harvester for maximum productivity.',
          price: 550.00,
          imageUrl: 'https://www.deere.com/assets/images/region-4/products/combines/s-series/s700/s790_combine_r4d088229_large.jpg',
          ownerId: user.uid,
          isAvailable: true,
          availableDates: [DateTime.now()],
          category: 'Harvester',
          country: 'Bangladesh',
          division: 'Rajshahi',
        ),
        Equipment(
          id: '',
          name: 'Case IH Axial-Flow',
          description: 'Efficient and reliable harvester for various crops.',
          price: 575.00,
          imageUrl: 'https://assets.cnhindustrial.com/caseih/NAFTA/NAFTAASSETS/Products/Harvesting/Axial-Flow-250-Series/axial-flow-250-series-combine-01.jpg',
          ownerId: user.uid,
          isAvailable: true,
          availableDates: [DateTime.now()],
          category: 'Harvester',
          country: 'India',
          division: 'Maharashtra',
        ),
        Equipment(
          id: '',
          name: 'New Holland CR',
          description: 'Twin Rotor technology for high-capacity harvesting.',
          price: 560.00,
          imageUrl: 'https://agriculture.newholland.com/nar/en-us/PublishingImages/products/harvesting/cr-revelation-twin-rotor-combines/gallery/2021-new-holland-cr-revelation-twin-rotor-combines-01.jpg',
          ownerId: user.uid,
          isAvailable: false,
          availableDates: [],
          category: 'Harvester',
          country: 'India',
          division: 'Uttar Pradesh',
        ),
      ];

      for (final harvester in harvesters) {
        await equipmentService.addEquipment(harvester);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Harvester data seeded successfully!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final equipmentService = Provider.of<EquipmentService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Equipment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the equipment name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the equipment description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price per day'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price per day';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController, 
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the equipment category';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                initialValue: _selectedCountry,
                hint: const Text('Select Country'),
                items: _countries.map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: _onCountryChanged,
                validator: (value) => value == null ? 'Please select a country' : null,
              ),
              DropdownButtonFormField<String>(
                initialValue: _selectedDivision,
                hint: const Text('Select Division'),
                items: _divisions.map((String division) {
                  return DropdownMenuItem<String>(
                    value: division,
                    child: Text(division),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedDivision = newValue;
                  });
                },
                validator: (value) => value == null ? 'Please select a division' : null,
              ),
              const SizedBox(height: 20),
              _image != null
                  ? Image.file(_image!, height: 100)
                  : const Text('No image selected'),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && _image != null && user != null) {
                    final imageUrl = await _uploadImage(_image!);
                    final newEquipment = Equipment(
                      id: '',
                      name: _nameController.text,
                      description: _descriptionController.text,
                      price: double.parse(_priceController.text),
                      imageUrl: imageUrl,
                      ownerId: user.uid,
                      isAvailable: true, 
                      availableDates: [],
                      category: _categoryController.text, 
                      country: _selectedCountry!,
                      division: _selectedDivision!,
                    );
                    await equipmentService.addEquipment(newEquipment);
                    if (context.mounted) {
                      context.pop();
                    }
                  }
                },
                child: const Text('Add Equipment'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _seedData,
                child: const Text('Seed Tractor Data'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _seedHarvesterData,
                child: const Text('Seed Harvester Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
