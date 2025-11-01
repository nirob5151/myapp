
import 'package:flutter/material.dart';
import 'package:myapp/features/farm_management/models/farm.dart';
import 'package:myapp/features/farm_management/services/farm_service.dart';
import 'package:provider/provider.dart';

class AddFarmPage extends StatefulWidget {
  const AddFarmPage({super.key});

  @override
  AddFarmPageState createState() => AddFarmPageState();
}

class AddFarmPageState extends State<AddFarmPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Farm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Farm Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a farm name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
                onSaved: (value) {
                  _location = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final farm = Farm(
                      name: _name,
                      location: _location,
                      // Replace 'YOUR_OWNER_ID' with the actual owner ID
                      ownerId: 'YOUR_OWNER_ID',
                    );
                    context.read<FarmService>().addFarm(farm);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add Farm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
