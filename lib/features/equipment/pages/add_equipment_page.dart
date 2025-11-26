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
  final _rentalPriceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _locationController = TextEditingController();
  final _availabilityController = TextEditingController();

  String? _selectedCountry;
  String? _selectedDivision;
  final List<File> _images = [];

  final LocationService _locationService = LocationService();
  late List<String> _countries;
  late List<String> _divisions;

  @override
  void initState() {
    super.initState();
    _countries = _locationService.getCountries();
    _divisions = [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _rentalPriceController.dispose();
    _categoryController.dispose();
    _locationController.dispose();
    _availabilityController.dispose();
    super.dispose();
  }

  void _onCountryChanged(String? newValue) {
    setState(() {
      _selectedCountry = newValue;
      _selectedDivision = null;
      _divisions = _locationService.getDivisions(newValue ?? '');
    });
  }

  Future<void> _pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      _images.addAll(pickedFiles.map((file) => File(file.path)));
    });
  }

  Future<List<String>> _uploadImages(List<File> images) async {
    final List<String> imageUrls = [];
    for (var image in images) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('equipment_images')
          .child('${DateTime.now().toIso8601String()}_${image.path.split('/').last}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }

  Future<void> _seedData() async {
    final equipmentService = Provider.of<EquipmentService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    if (user != null) {
      final tractors = [
        Equipment(
            id: '',
            name: 'John Deere 8R 370',
            description: 'A powerful and versatile tractor for all your farming needs.',
            rentalPrice: 250.00,
            imageUrls: ['https://www.deere.co.uk/assets/images/region-2/products/tractors/8r-series/8r-370/8r_370_r2d082779_large_3206e6402434b32a5384385e5893392a4582f346.jpg'],
            ownerId: user.uid,
            isAvailable: true,
            availableDates: [DateTime.now()],
            category: 'Tractor',
            country: 'Bangladesh',
            division: 'Dhaka',
            location: 'Dhaka, Bangladesh',
            availability: 'Available'),
        Equipment(
            id: '',
            name: 'Case IH Magnum 380',
            description: 'High-performance tractor with a comfortable cab.',
            rentalPrice: 275.00,
            imageUrls: ['https://assets.cnhindustrial.com/caseih/NAFTA/NAFTAASSETS/Products/Tractors/Magnum-Series/magnum-380/Magnum-380-Tractor-01.jpg'],
            ownerId: user.uid,
            isAvailable: true,
            availableDates: [DateTime.now()],
            category: 'Tractor',
            country: 'Bangladesh',
            division: 'Chittagong',
            location: 'Chittagong, Bangladesh',
            availability: 'Available'),
        Equipment(
            id: '',
            name: 'New Holland T8',
            description: 'A reliable and efficient tractor for modern farming.',
            rentalPrice: 260.00,
            imageUrls: ['https://agriculture.newholland.com/nar/en-us/PublishingImages/products/tractors-telehandlers/t8-genesis-plmi/gallery/2021-new-holland-t8-genesis-plmi-01.jpg'],
            ownerId: user.uid,
            isAvailable: false,
            availableDates: [],
            category: 'Tractor',
            country: 'India',
            division: 'Punjab',
            location: 'Punjab, India',
            availability: 'Not Available'),
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
    final equipmentService = Provider.of<EquipmentService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    if (user != null) {
      final harvesters = [
        Equipment(
            id: '',
            name: 'John Deere S700',
            description: 'Advanced combine harvester for maximum productivity.',
            rentalPrice: 550.00,
            imageUrls: ['https://www.deere.com/assets/images/region-4/products/combines/s-series/s700/s790_combine_r4d088229_large.jpg'],
            ownerId: user.uid,
            isAvailable: true,
            availableDates: [DateTime.now()],
            category: 'Harvester',
            country: 'Bangladesh',
            division: 'Rajshahi',
            location: 'Rajshahi, Bangladesh',
            availability: 'Available'),
        Equipment(
            id: '',
            name: 'Case IH Axial-Flow',
            description: 'Efficient and reliable harvester for various crops.',
            rentalPrice: 575.00,
            imageUrls: ['https://assets.cnhindustrial.com/caseih/NAFTA/NAFTAASSETS/Products/Harvesting/Axial-Flow-250-Series/axial-flow-250-series-combine-01.jpg'],
            ownerId: user.uid,
            isAvailable: true,
            availableDates: [DateTime.now()],
            category: 'Harvester',
            country: 'India',
            division: 'Maharashtra',
            location: 'Maharashtra, India',
            availability: 'Available'),
        Equipment(
            id: '',
            name: 'New Holland CR',
            description: 'Twin Rotor technology for high-capacity harvesting.',
            rentalPrice: 560.00,
            imageUrls: ['https://agriculture.newholland.com/nar/en-us/PublishingImages/products/harvesting/cr-revelation-twin-rotor-combines/gallery/2021-new-holland-cr-revelation-twin-rotor-combines-01.jpg'],
            ownerId: user.uid,
            isAvailable: false,
            availableDates: [],
            category: 'Harvester',
            country: 'India',
            division: 'Uttar Pradesh',
            location: 'Uttar Pradesh, India',
            availability: 'Not Available'),
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
      body: SingleChildScrollView(
        child: Padding(
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
                  controller: _rentalPriceController,
                  decoration: const InputDecoration(labelText: 'Rental Price per day'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the rental price per day';
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
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _availabilityController,
                  decoration: const InputDecoration(labelText: 'Availability'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the availability';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  hint: const Text('Select Country'),
                  items: _countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: _onCountryChanged,
                  validator: (value) =>
                      value == null ? 'Please select a country' : null,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedDivision,
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
                  validator: (value) =>
                      value == null ? 'Please select a division' : null,
                ),
                const SizedBox(height: 20),
                _images.isNotEmpty
                    ? SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(_images[index]),
                            );
                          },
                        ),
                      )
                    : const Text('No images selected'),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: const Text('Pick Images'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _images.isNotEmpty &&
                        user != null) {
                      final imageUrls = await _uploadImages(_images);
                      final newEquipment = Equipment(
                        id: '',
                        name: _nameController.text,
                        description: _descriptionController.text,
                        rentalPrice: double.parse(_rentalPriceController.text),
                        imageUrls: imageUrls,
                        ownerId: user.uid,
                        isAvailable: true, // This should be handled properly
                        availableDates: [], // This should be handled properly
                        category: _categoryController.text,
                        country: _selectedCountry!,
                        division: _selectedDivision!,
                        location: _locationController.text,
                        availability: _availabilityController.text,
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
      ),
    );
  }
}
