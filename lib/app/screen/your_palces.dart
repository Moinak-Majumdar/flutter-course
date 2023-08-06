import 'package:favorite_place/app/screen/new_place.dart';
import 'package:favorite_place/app/widgets/place_card.dart';
import 'package:favorite_place/provider/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YourPlaces extends ConsumerStatefulWidget {
  const YourPlaces({super.key});

  @override
  ConsumerState<YourPlaces> createState() => _YourPlacesState();
}

class _YourPlacesState extends ConsumerState<YourPlaces> {
  late Future<void> _placesDb;

  @override
  void initState() {
    _placesDb = ref.read(placeProvider.notifier).initializePlaces();
    super.initState();
  }

  @override
  Widget build(context) {
    final placeList = ref.watch(placeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Places',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const NewPlace(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _placesDb,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (placeList.isEmpty) {
            return const NoPlace();
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            itemCount: placeList.length,
            itemBuilder: (ctx, index) => PlaceCard(
              place: placeList[index],
            ),
          );
        },
      ),
    );
  }
}

class NoPlace extends StatelessWidget {
  const NoPlace({super.key});

  @override
  Widget build(context) {
    return Center(
      child: Text(
        'No places are added yet.',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
