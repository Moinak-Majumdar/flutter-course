import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
const Map<String, IconData> _available = {
  'Home': Icons.home,
  'Hospital': Icons.local_hospital,
  'Airport': Icons.flight_takeoff,
  'Apartment': Icons.apartment_rounded,
  'Bath House': Icons.bathtub_rounded,
  'Blood Bank': Icons.bloodtype_rounded,
  'Garage': Icons.car_repair,
  'Castle': Icons.castle,
  'Cafe': Icons.coffee_rounded,
  'Construction Site': Icons.construction,
  'Coast': Icons.directions_boat_rounded,
  'Bus Stand': Icons.directions_bus,
  'Railway Station': Icons.directions_railway,
  'EV Charge Station': Icons.ev_station,
  'Factory': Icons.factory,
  'Fire Brigade': Icons.fire_truck_rounded,
  'Bar': Icons.liquor,
  'ATM': Icons.local_atm,
  'Gas Station': Icons.local_gas_station,
  'Grocery Store': Icons.local_grocery_store,
  'Hotel': Icons.local_hotel,
  'Library': Icons.local_library_rounded,
  'Theater': Icons.movie_rounded,
  'Unknown': Icons.pin_drop,
  'Beach': Icons.pool,
  'Restaurant': Icons.room_service,
  'Stadium': Icons.stadium,
  'Studio': Icons.video_camera_front_rounded,
  'Medical Shop': Icons.medication_liquid,
  'Office': Icons.work,
  'Bank': Icons.account_balance
};
Map<String, IconData> get availableIcons {
  final entries = _available.entries.toList();
  entries.sort((a, b) => a.key.compareTo(b.key));
  return Map.fromEntries(entries);
}

class PlaceMarker {
  PlaceMarker.byMarker({required this.icon, required this.iconColor})
      : iconKey = _available.keys.firstWhere((k) => _available[k] == icon);
  PlaceMarker.byMarkerName({required this.iconKey, required this.iconColor})
      : icon = _available[iconKey]!;

  String iconKey;
  IconData icon;
  Color iconColor;

  String get hexColor => '0xFF${iconColor.value.toRadixString(16)}';
}

class PlaceLocation {
  PlaceLocation({
    required this.lat,
    required this.lon,
    required this.continent,
    required this.postcode,
    required this.city,
    required this.cityDes,
    required this.locality,
    required this.localityDes,
  });
  final double lat, lon;
  final String continent, postcode, city, locality, cityDes, localityDes;

  String get address => '$locality, $localityDes';
  String get nearest => 'Nearest : $city, $cityDes';
  String get pin =>
      postcode == '' ? 'Postcode : Not Found!' : 'Postcode : $postcode';
}

class Place {
  Place({
    required this.title,
    required this.thumbNail,
    required this.location,
    required this.marker,
    String? id,
  }) : id = id ?? uuid.v4();

  final String title, id;
  final File thumbNail;
  final PlaceLocation location;
  final PlaceMarker marker;

  String get dbFriendlyId => id.replaceAll(RegExp('-'), '_');
}
