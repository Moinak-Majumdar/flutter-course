import 'package:flutter/material.dart';
import 'package:kharcha/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text("₹${expense.amount.toStringAsFixed(2)}"),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      dateFormat(expense.date),
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
