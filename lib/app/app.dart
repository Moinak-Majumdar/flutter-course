import 'package:flutter/material.dart';
import 'package:kharcha/app/screens/expenses_list.dart';
import 'package:kharcha/app/screens/new_expense.dart';
import 'package:kharcha/app/widget/chart/chart.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kharcha',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: 26,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => const Chart(),
                );
              },
              icon: Icon(
                Icons.bar_chart,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const NewExpense(),
                  ),
                );
              },
              icon: Icon(
                Icons.add_rounded,
                size: 34,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ExpensesList(),
          ),
        ],
      ),
    );
  }
}
