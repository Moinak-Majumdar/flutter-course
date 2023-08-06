import 'dart:io';
import 'package:favorite_place/app/widgets/image_input.dart';
import 'package:favorite_place/app/widgets/location_input.dart';
import 'package:favorite_place/app/widgets/validation_alerts.dart';
import 'package:favorite_place/models/place.dart';
import 'package:favorite_place/provider/place_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  static final _formKey = GlobalKey<FormState>();
  String _enteredTitle = '';
  File? _selectedImage;
  PlaceLocation? _pickedLocation;
  PlaceMarker? _selectedMarker;

  void _handelSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_selectedImage == null) {
        showCupertinoDialog(
            context: context, builder: (ctx) => ImageAlert(ctx));
        return;
      }
      if (_pickedLocation == null) {
        showCupertinoDialog(
            context: context, builder: (ctx) => LocationAlert(ctx));
        return;
      }
      if (_selectedMarker == null) {
        showCupertinoDialog(context: context, builder: (ctx) => IconAlert(ctx));
        return;
      }
      ref.read(placeProvider.notifier).addPlace(
            title: _enteredTitle,
            image: _selectedImage!,
            location: _pickedLocation!,
            marker: _selectedMarker!,
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add place',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Required *';
                    }
                    if (val.trim().length < 3 || val.trim().length > 50) {
                      return 'Must be between 3 and 50 characters long.';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _enteredTitle = val!;
                  },
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                ),
                // hl2 take picture.
                ImageInput(onSelectImage: (img) {
                  _selectedImage = img;
                }),
                // hl3 get location.
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: LocationInput(
                    onLocationSet: (location) {
                      _pickedLocation = location;
                    },
                    onMarkerSet: (marker) {
                      _selectedMarker = marker;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                        ImageInput.imgReset.currentState!.hardReset();
                        LocationInput.locationReset.currentState!.hardReset();
                      },
                      child: Text(
                        'Reset',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _handelSubmit,
                      icon: const Icon(Icons.add),
                      label: Text(
                        'Add Place',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
