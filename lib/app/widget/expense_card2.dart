import 'package:flutter/material.dart';
import 'package:kharcha/models/expense.dart';

class ExpenseCard2 extends StatelessWidget {
  const ExpenseCard2(this.expense, {super.key});

  final Expense expense;

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          expense.title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateFormat(expense.date),
                softWrap: true,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "₹${expense.amount.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24,
                    ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            style: Theme.of(context).elevatedButtonTheme.style,
            child: const Text('Okey'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(context) {
    final darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
      child: ListTile(
        onTap: () {
          _showDetails(context);
        },
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: darkMode
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            categoryIcons[expense.category],
            color: Theme.of(context).colorScheme.primary,
            size: 36,
          ),
        ),
        title: Text(
          expense.title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
        ),
        subtitle: Text(
          dateFormat(expense.date),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
        trailing: Text(
          expense.category.name.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
    );
  }
}
