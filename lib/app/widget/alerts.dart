import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailedAlert extends StatelessWidget {
  const FailedAlert({super.key, required this.buildCtx});

  final BuildContext buildCtx;

  @override
  Widget build(context) {
    return CupertinoAlertDialog(
      title: Text(
        'Invalid input',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      content: const Text(
          'Please make sure valid title, amount, date and category was entered...'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(buildCtx);
          },
          child: const Text('OKAY'),
        ),
      ],
    );
  }
}

class SuccessAlert extends StatelessWidget {
  const SuccessAlert({super.key, required this.buildCtx});

  final BuildContext buildCtx;

  @override
  Widget build(context) {
    return CupertinoAlertDialog(
      title: Text(
        'New Kharcha added.',
        style: GoogleFonts.comicNeue(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(buildCtx);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
