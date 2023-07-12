import 'package:flutter/material.dart';
import 'package:kharcha/app/widget/expenses_list.dart';
import 'package:kharcha/app/widget/new_expense.dart';
import 'package:kharcha/models/expense.dart';
// import 'package:kharcha/data/dataList.dart';
import 'package:kharcha/app/widget/chart/chart.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  final List<Expense> _registeredExpenses = [];

  void _addExpenseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _chartModal() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Chart(
        expenses: _registeredExpenses,
        dataAvailable: _registeredExpenses.isNotEmpty,
      ),
    );
  }

  void _addExpense(Expense e) {
    setState(() {
      _registeredExpenses.add(e);
    });
  }

  void _removeExpense(Expense e) {
    setState(() {
      _registeredExpenses.remove(e);
    });
  }

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
              onPressed: _chartModal,
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
              onPressed: _addExpenseModal,
              icon: Icon(
                Icons.add_rounded,
                size: 34,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
              onRemoveExpense: _removeExpense,
              dataAvailable: _registeredExpenses.isNotEmpty,
            ),
          ),
        ],
      ),
    );
  }
}
