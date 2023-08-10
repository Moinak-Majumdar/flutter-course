import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharcha/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(context) {
    final darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              darkMode
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.0)
                  : Theme.of(context).colorScheme.primaryContainer,
              darkMode
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                  : Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.0)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style:
                  GoogleFonts.ubuntu(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  "₹${expense.amount.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      categoryIcons[expense.category],
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      dateFormat(
                        expense.date,
                      ),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
