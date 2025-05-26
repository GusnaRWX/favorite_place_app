import 'dart:io';
import 'package:favorite_place_app/models/place.dart';
import 'package:favorite_place_app/providers/user_places.dart';
import 'package:favorite_place_app/widgets/image_input.dart';
import 'package:favorite_place_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceState();
  }
}

class _AddPlaceState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();

  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteredText = _titleController.text;

    if (enteredText.isEmpty || _selectedImage == null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredText, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add new place")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            SizedBox(height: 10),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            SizedBox(height: 10),
            LocationInput(
              onPlaceLocation: (location) {
                _selectedLocation = location;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                _savePlace();
              },
              icon: Icon(Icons.add),
              label: Text('Add place'),
            ),
          ],
        ),
      ),
    );
  }
}
