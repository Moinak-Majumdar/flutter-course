import 'package:flutter/material.dart';
import 'package:kharcha/app/widget/expenses_list.dart';
import 'package:kharcha/app/widget/new_expense.dart';
import 'package:kharcha/app/widget/chart/chart.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kharcha',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: IconButton(
              onPressed: () {
                _chartModal(context);
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
                _addExpenseModal(context);
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

void _addExpenseModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    // constraints: const BoxConstraints(
    //   minWidth: double.infinity,
    // ),
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => const NewExpense(),
  );
}

void _chartModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) => const Chart(),
  );
}
