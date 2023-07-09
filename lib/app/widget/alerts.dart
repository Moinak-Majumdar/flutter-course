import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailedAlert extends StatelessWidget {
  const FailedAlert({super.key, required this.buildCtx});

  final BuildContext buildCtx;

  @override
  Widget build(context) {
    return AlertDialog(
      title: Text(
        'Invalid input',
        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      content: const Text(
          'Please make sure valid title, amount, date and category was entered...'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(buildCtx);
          },
          child: const Text('Okay'),
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
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New Kharcha added.',
              style: GoogleFonts.comicNeue(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(buildCtx);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
