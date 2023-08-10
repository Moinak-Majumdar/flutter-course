import 'package:clean_dialog/clean_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kharcha/app/widget/expense_card.dart';
import 'package:kharcha/app/widget/expense_card2.dart';
import 'package:kharcha/models/expense.dart';
import 'package:kharcha/provider/expense_provider.dart';

class ExpenseListItem extends ConsumerWidget {
  const ExpenseListItem({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(context, ref) {
    final darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => CleanDialog(
            backgroundColor: darkMode
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context).colorScheme.primary,
            title: 'Confirmation',
            content:
                "Do you want to delete `${expense.title}`?   Created at : ${dateFormat(
              expense.date,
              fullDay: true,
            )}",
            titleTextStyle: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
            contentTextStyle:
                const TextStyle(fontSize: 16, color: Colors.white),
            actions: [
              CleanDialogActionButtons(
                actionTitle: 'Cancel',
                textColor: Theme.of(context).colorScheme.primary,
                onPressed: () => Navigator.pop(context),
              ),
              CleanDialogActionButtons(
                actionTitle: 'Delete',
                textColor: Theme.of(context).colorScheme.error,
                onPressed: () {
                  ref.read(expenseProvider.notifier).removeExpense(expense);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
      key: ValueKey(expense),
      child: ExpenseCard2(expense),
    );
  }
}
