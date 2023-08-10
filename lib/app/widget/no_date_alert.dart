import 'package:flutter/material.dart';
import 'package:kharcha/models/expense.dart';

class NoDateAlert extends StatelessWidget {
  const NoDateAlert(
      {super.key, required this.onDatePick, required this.buildContext});
  final void Function(DateTime d) onDatePick;
  final BuildContext buildContext;

  @override
  Widget build(context) {
    return AlertDialog(
      title: Text(
        'Attention !',
        style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w700),
      ),
      content: const Text(
        'Opps! You have missed to pick the date.',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(buildContext);
            onDatePick(today);
          },
          icon: const Icon(Icons.calendar_month_rounded),
          label: const Text('Pick a date'),
        ),
      ],
    );
  }
}
