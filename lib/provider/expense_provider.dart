import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kharcha/hive_model.dart';
import 'package:kharcha/models/expense.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]);

  final _hiveBoxName = 'records';

  Future<void> getMemoryItem() async {
    final box = await Hive.openBox<HiveModel>(_hiveBoxName);
    // await box.clear();
    final List<Expense> expenses = [];
    for (int i = 0; i < box.length; i++) {
      final item = box.getAt(i)!;
      expenses.add(
        Expense(
          amount: item.amount,
          date: item.date,
          title: item.title,
          category: Category.values.firstWhere(
              (element) => element.toString() == "Category.${item.category}"),
          id: item.id,
        ),
      );
    }
    state = expenses.reversed.toList();
  }

  void addExpense(Expense e) async {
    state = [e, ...state];
    final box = await Hive.openBox<HiveModel>(_hiveBoxName);
    await box.put(
      e.dbFriendlyId,
      HiveModel(
        id: e.dbFriendlyId,
        title: e.title,
        amount: e.amount,
        category: e.category.name,
        date: e.date,
      ),
    );
  }

  void removeExpense(Expense e) async {
    state = state.where((element) => element.id != e.id).toList();
    final box = await Hive.openBox<HiveModel>(_hiveBoxName);
    box.delete(e.dbFriendlyId);
  }
}

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>(
  (ref) => ExpenseNotifier(),
);
