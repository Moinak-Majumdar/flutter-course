import 'dart:convert';

import 'package:favorite_place/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  LocationInput({required this.onLocationSet, required this.onMarkerSet})
      : super(key: locationReset);
  final void Function(PlaceLocation pl) onLocationSet;
  final void Function(PlaceMarker pm) onMarkerSet;
  static final GlobalKey<LocationInputState> locationReset =
      GlobalKey<LocationInputState>();

  @override
  State<LocationInput> createState() => LocationInputState();
}

class LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  PlaceMarker? _pickedMarker;
  bool _isGettingLocation = false;
  Color pickerColor = Colors.black;

  // hl5  fetching user current location.
  void _getCurrentLocation() async {
    if (_pickedLocation != null) {
      return;
    }
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    late LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lon = locationData.longitude;
    if (lat == null || lon == null) {
      return;
    }
    final url = Uri.parse(
        'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$lon&localityLanguage=en');
    final response = await http.get(url);
    final resData = jsonDecode(response.body);
    final continent = resData['continent'];
    final postcode = resData['postcode'];
    final city = resData['city'];
    final locality = resData['locality'];
    final administrative = resData['localityInfo']['administrative'];
    final cityDes = administrative[3]['description'];
    final localityDes = administrative[4]['description'];

    setState(() {
      _pickedLocation = PlaceLocation(
        lat: lat,
        lon: lon,
        continent: continent,
        postcode: postcode,
        city: city,
        cityDes: cityDes,
        locality: locality,
        localityDes: localityDes,
      );
      _isGettingLocation = false;
      widget.onLocationSet(_pickedLocation!);
    });
  }

  // hl4 icon picker.
  void pickMarker() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      customIconPack: availableIcons,
      iconPackModes: <IconPack>[IconPack.custom],
      showSearchBar: false,
      title: Text(
        'Select a marker !',
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.white70,
            ),
      ),
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      iconSize: 50,
      iconColor: Theme.of(context).colorScheme.secondary,
    );
    if (icon != null) {
      setState(() {
        _pickedMarker =
            PlaceMarker.byMarker(icon: icon, iconColor: pickerColor);
        widget.onMarkerSet(_pickedMarker!);
        changeMarkerColor();
      });
    }
  }

  // hl3  change marker color.
  void changeMarkerColor() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Marker color !',
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: pickerColor,
            onColorChanged: (col) {
              setState(() {
                pickerColor = col;
              });
            },
          ),
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.done_all),
            label: const Text('Got it'),
            onPressed: () {
              setState(() {
                _pickedMarker = PlaceMarker.byMarker(
                  icon: _pickedMarker!.icon,
                  iconColor: pickerColor,
                );
                widget.onMarkerSet(_pickedMarker!);
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void hardReset() {
    setState(() {
      _isGettingLocation = false;
      _pickedLocation = null;
      _pickedMarker = null;
    });
  }

  @override
  Widget build(context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueGrey,
                Colors.deepPurple,
                Theme.of(context).colorScheme.onSecondary
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _isGettingLocation
                  ? const CircularProgressIndicator()
                  : _pickedLocation == null
                      ? const Text(
                          'No location is selected yet.',
                          style: TextStyle(fontSize: 18),
                        )
                      : Text(
                          _pickedLocation!.address,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
              if (_pickedMarker != null)
                Container(
                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 4,
                    left: 10,
                    right: 4,
                  ),
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(.6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _pickedMarker!.iconKey,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 24,
                        child: IconButton(
                          onPressed: changeMarkerColor,
                          icon: Icon(
                            _pickedMarker!.icon,
                            size: 30,
                            color: _pickedMarker!.iconColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: Text(
                _pickedLocation == null
                    ? 'Get current location.'
                    : 'Location fetched.',
              ),
            ),
            TextButton.icon(
              onPressed: pickMarker,
              icon: const Icon(Icons.label),
              label: Text(
                _pickedMarker == null ? 'Select marker.' : 'Change Marker',
              ),
            ),
          ],
        )
      ],
    );
  }
}
