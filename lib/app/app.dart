import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharcha/app/widget/expenses_list.dart';
import 'package:kharcha/app/widget/new_expense.dart';
import 'package:kharcha/models/expense.dart';
// import 'package:kharcha/data/dataList.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  final List<Expense> _registeredExpenses = [];

  void _showModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
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
          style: GoogleFonts.comicNeue(
            fontSize: 34,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
              onPressed: _showModal,
              icon: const Icon(
                Icons.add,
                size: 34,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('List Items'),
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
              onRemoveExpense: _removeExpense,
            ),
          ),
        ],
      ),
    );
  }
}
