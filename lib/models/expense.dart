import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
final DateTime today = DateTime.now();

String dateFormat(DateTime d, {bool fullDay = false}) {
  final date = DateFormat.yMd().format(d);
  final sortDay = DateFormat.E().format(d);
  final day = DateFormat.EEEE().format(d);

  return fullDay ? '$day, $date' : '$sortDay, $date';
}

enum Category {
  drinks,
  electricity,
  food,
  gas,
  gym,
  houseRent,
  internet,
  leisure,
  savings,
  shopping,
  study,
  travel,
  unknown,
  work,
}

const categoryIcons = {
  Category.unknown: Icons.question_mark_outlined,
  Category.food: Icons.restaurant,
  Category.travel: Icons.commute,
  Category.study: Icons.school_outlined,
  Category.shopping: Icons.shopping_cart_outlined,
  Category.work: Icons.laptop_mac,
  Category.leisure: Icons.live_tv_outlined,
  Category.houseRent: Icons.location_city_rounded,
  Category.electricity: Icons.wb_incandescent_rounded,
  Category.gas: Icons.local_gas_station_rounded,
  Category.drinks: Icons.local_bar_rounded,
  Category.internet: Icons.http_rounded,
  Category.gym: Icons.fitness_center_outlined,
  Category.savings: Icons.account_balance_rounded,
};

class Expense {
  Expense({
    required this.amount,
    required this.date,
    required this.title,
    required this.category,
    String? id,
  }) : id = id ?? _uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get dbFriendlyId => id.replaceAll(RegExp('-'), '_');
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double total = 0;

    for (final e in expenses) {
      total += e.amount;
    }

    return total;
  }
}
