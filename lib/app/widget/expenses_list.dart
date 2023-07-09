import 'package:flutter/material.dart';
import 'package:kharcha/app/widget/expense_card.dart';
import 'package:kharcha/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense e) onRemoveExpense;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Confirmation'),
              content: const Text('Do you want to delete current post?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    onRemoveExpense(expenses[index]);
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('DELETE'),
                ),
              ],
            ),
          );
        },
        key: ValueKey(expenses[index]),
        child: ExpenseCard(expenses[index]),
      ),
    );
  }
}
