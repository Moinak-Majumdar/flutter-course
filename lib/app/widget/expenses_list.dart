import 'package:flutter/material.dart';
import 'package:kharcha/app/widget/expense_card.dart';
import 'package:kharcha/models/expense.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key,
      required this.expenses,
      required this.onRemoveExpense,
      required this.dataAvailable});

  final List<Expense> expenses;
  final bool dataAvailable;
  final void Function(Expense e) onRemoveExpense;

  @override
  Widget build(context) {
    return dataAvailable
        ? ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) => Dismissible(
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(
                      'Confirmation',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "Do you want to delete `${expenses[index].title}`?"),
                        const SizedBox(height: 8),
                        Text(
                          "Created at : ${dateFormat(
                            expenses[index].date,
                            fullDay: true,
                          )}",
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () {
                          onRemoveExpense(expenses[index]);
                          Navigator.of(ctx).pop(true);
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
                );
              },
              key: ValueKey(expenses[index]),
              child: ExpenseCard(expenses[index]),
            ),
          )
        : SizedBox(
            height: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'List is not available, Add Kharcha to view list',
                style: GoogleFonts.comicNeue(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
