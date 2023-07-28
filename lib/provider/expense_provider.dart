import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kharcha/models/expense.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void manipulateExpenseMemory(List<Expense> expenses) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String> expensesToStringList = [];

  for (final e in expenses) {
    final Map<String, String> map = {
      "id": e.id,
      "amount": e.amount.toString(),
      "category": e.category.name,
      "date": e.date.toString(),
      "title": e.title,
    };
    expensesToStringList.add(
      jsonEncode(map),
    );
  }

  await prefs.setStringList('expenseList', expensesToStringList);
}

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]);

  void initializeMemory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final memory = prefs.getStringList('expenseList');

    final List<Expense> expensesList = [];

    if (memory != null && memory.isNotEmpty) {
      for (final m in memory) {
        final Map<String, dynamic> map = jsonDecode(m);
        expensesList.add(
          Expense.reInitialize(
            amount: double.tryParse(map['amount']!) ?? 0,
            date: DateTime.parse(map['date']!),
            title: map['title']!,
            category: Category.values.firstWhere((element) =>
                element.toString() == "Category." + map['category']!),
            id: map['id']!,
          ),
        );
      }
    }

    state = [...expensesList];
  }

  void addExpense(Expense e) {
    state = [...state, e];
    manipulateExpenseMemory(state);
  }

  void removeExpense(Expense e) {
    state = state.where((element) => element.id != e.id).toList();
    print('dismiss');
    manipulateExpenseMemory(state);
  }
}

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>(
  (ref) => ExpenseNotifier(),
);

final expenseProviderWithMemory = Provider<List<Expense>>((ref) {
  ref.read(expenseProvider.notifier).initializeMemory();

  return ref.watch(expenseProvider);
});
