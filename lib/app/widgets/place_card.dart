import 'package:favorite_place/app/screen/place_details.dart';
import 'package:favorite_place/models/place.dart';
import 'package:favorite_place/provider/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceCard extends ConsumerWidget {
  const PlaceCard({super.key, required this.place});
  final Place place;

  @override
  Widget build(context, ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Dismissible(
        key: ValueKey(place.id),
        confirmDismiss: (dir) => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            title: const Text('Confirmation'),
            content: Text('Do you wan to delete : ${place.title} ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(placeProvider.notifier)
                      .deletePlace(id: place.dbFriendlyId);
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'DELETE',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ],
          ),
        ),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => PlaceDetails(place: place),
              ),
            );
          },
          leading: Container(
            clipBehavior: Clip.hardEdge,
            width: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Image.file(
              place.thumbNail,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            place.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.cyan),
          ),
          subtitle: Text(
            place.location.locality,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          trailing: Hero(
            tag: place.id,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                place.marker.icon,
                size: 30,
                color: place.marker.iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
