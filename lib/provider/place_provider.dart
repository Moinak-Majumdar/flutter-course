import 'dart:io';

import 'package:favorite_place/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as directory;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  // await sql.deleteDatabase('places.db'); //hl2 reset db in case db error.
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lon REAL, continent TEXT, city TEXT,cityDes TEXT, locality TEXT, localityDes TEXT, pin TEXT,   marker TEXT, markerColor TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class PlaceNotifier extends StateNotifier<List<Place>> {
  PlaceNotifier() : super([]);

  Future<void> initializePlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');

    if (data.isNotEmpty) {
      final List<Place> places = data
          .map(
            (row) => Place(
              id: row['id'] as String,
              title: row['title'] as String,
              thumbNail: File(row['image'] as String),
              location: PlaceLocation(
                lat: row['lat'] as double,
                lon: row['lon'] as double,
                continent: row['continent'] as String,
                postcode: row['pin'] as String,
                city: row['city'] as String,
                cityDes: row['cityDes'] as String,
                locality: row['locality'] as String,
                localityDes: row['localityDes'] as String,
              ),
              marker: PlaceMarker.byMarkerName(
                iconKey: row['marker'] as String,
                iconColor: Color(
                  int.tryParse(row['markerColor'] as String) ?? 0xFF000000,
                ),
              ),
            ),
          )
          .toList();

      state = places.reversed.toList();
    }
  }

  void addPlace(
      {required String title,
      required File image,
      required PlaceLocation location,
      required PlaceMarker marker}) async {
    final appDir = await directory.getApplicationDocumentsDirectory();
    final workDir = Directory('${appDir.path}/thumbnails/');
    String workDirPath;
    if (await workDir.exists()) {
      workDirPath = workDir.path;
    } else {
      final newFolder = await workDir.create(recursive: true);
      workDirPath = newFolder.path;
    }
    final fileName = path.basename(image.path);
    final copiedPath = await image.copy('$workDirPath/$fileName');

    Place p = Place(
      title: title,
      thumbNail: copiedPath,
      location: location,
      marker: marker,
    );
    final db = await _getDatabase();
    await db.insert('user_places', {
      'id': p.dbFriendlyId,
      'image': p.thumbNail.path,
      'title': p.title,
      'lat': p.location.lat,
      'lon': p.location.lon,
      'continent': p.location.continent,
      'pin': p.location.postcode,
      'city': p.location.city,
      'cityDes': p.location.cityDes,
      'locality': p.location.locality,
      'localityDes': p.location.localityDes,
      'marker': p.marker.iconKey,
      'markerColor': p.marker.hexColor
    });
    state = [p, ...state];
  }

  void deletePlace({required String id}) async {
    final db = await _getDatabase();
    db.execute("DELETE FROM user_places WHERE id = '$id'");
    state = state.where((e) => e.id != id).toList();
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Place>>(
  (ref) => PlaceNotifier(),
);
