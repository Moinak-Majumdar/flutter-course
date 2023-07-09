import 'package:kharcha/models/expense.dart';

final List<Expense> dummy = [
  Expense(
    title: 'Flutter course',
    amount: 499,
    category: Category.study,
    date: DateTime.now(),
  ),
  Expense(
    title: 'Cinema',
    amount: 299,
    category: Category.leisure,
    date: DateTime.now(),
  ),
];
