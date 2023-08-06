import 'package:favorite_place/app/screen/place_details.dart';
import 'package:favorite_place/models/place.dart';
import 'package:favorite_place/provider/place_provider.dart';
import 'package:flutter/cupertino.dart';
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
        confirmDismiss: (dir) => showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
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
                  'CANCEL',
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
          leading: Hero(
            tag: place.id,
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: 60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              child: Image.file(
                place.thumbNail,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            place.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          subtitle: Text(
            place.location.locality,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          trailing: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              place.marker.icon,
              size: 30,
              color: place.marker.iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
