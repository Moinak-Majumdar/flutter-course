import 'package:flutter/material.dart';

class ImageAlert extends StatelessWidget {
  const ImageAlert(this.context, {super.key});
  final BuildContext context;

  @override
  Widget build(context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.scrim,
      title: Text(
        'Attention !',
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      content: const Text('Please take / upload an image.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Okey'),
        )
      ],
    );
  }
}

class LocationAlert extends StatelessWidget {
  const LocationAlert(this.context, {super.key});
  final BuildContext context;

  @override
  Widget build(context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.scrim,
      title: Text(
        'Attention !',
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      content: const Text('Please add location of current place.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Okey'),
        )
      ],
    );
  }
}

class IconAlert extends StatelessWidget {
  const IconAlert(this.context, {super.key});
  final BuildContext context;

  @override
  Widget build(context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.scrim,
      title: Text(
        'Attention !',
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      content: const Text('Please select a marker icon.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Okey'),
        )
      ],
    );
  }
}
