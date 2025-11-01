import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
  DateTime? _plantingDate;
  DateTime? _harvestDate;

  final TextEditingController _plantingDateController = TextEditingController();
  final TextEditingController _harvestDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, {required bool isPlantingDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isPlantingDate) {
          _plantingDate = picked;
          _plantingDateController.text = DateFormat.yMd().format(picked);
        } else {
          _harvestDate = picked;
          _harvestDateController.text = DateFormat.yMd().format(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Crop', style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Crop Details',
                style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Crop Name',
                  labelStyle: GoogleFonts.roboto(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.grass),
                ),
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
              const SizedBox(height: 20),
              TextFormField(
                controller: _plantingDateController,
                decoration: InputDecoration(
                  labelText: 'Planting Date',
                  labelStyle: GoogleFonts.roboto(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, isPlantingDate: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a planting date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _harvestDateController,
                decoration: InputDecoration(
                  labelText: 'Harvest Date',
                  labelStyle: GoogleFonts.roboto(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, isPlantingDate: false),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a harvest date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final crop = Crop(
                      name: _name,
                      plantingDate: DateFormat.yMd().format(_plantingDate!),
                      harvestDate: DateFormat.yMd().format(_harvestDate!),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Add Crop'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _plantingDateController.dispose();
    _harvestDateController.dispose();
    super.dispose();
  }
}
