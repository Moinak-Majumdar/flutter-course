import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kharcha/app/widget/expense_card.dart';
import 'package:kharcha/models/expense.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharcha/provider/expense_provider.dart';

class ExpensesList extends ConsumerWidget {
  const ExpensesList({super.key});

  @override
  Widget build(context, WidgetRef ref) {
    final List<Expense> expenses = ref.watch(expenseProviderWithMemory);
    final bool dataAvailable = expenses.isNotEmpty;

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
                        const SizedBox(height: 12),
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
                          ref
                              .read(expenseProvider.notifier)
                              .removeExpense(expenses[index]);
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'No kharcha is found, Try adding some!',
                  style: GoogleFonts.comicNeue(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
  }
}
