import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/features/farm_management/models/crop.dart';
import 'package:myapp/features/farm_management/services/farm_service.dart';

class AddCropPage extends StatefulWidget {
  final String farmId;

  const AddCropPage({super.key, required this.farmId});

  @override
  AddCropPageState createState() => AddCropPageState();
}

class AddCropPageState extends State<AddCropPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _plantingDate = '';
  String _harvestDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Crop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Crop Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a crop name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Planting Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a planting date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _plantingDate = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Harvest Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a harvest date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _harvestDate = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final crop = Crop(
                      name: _name,
                      plantingDate: _plantingDate,
                      harvestDate: _harvestDate,
                      farmId: widget.farmId,
                    );
                    final farmService = Provider.of<FarmService>(context, listen: false);
                    final navigator = Navigator.of(context);
                    await farmService.addCrop(crop);
                    if (mounted) {
                      navigator.pop();
                    }
                  }
                },
                child: const Text('Add Crop'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
