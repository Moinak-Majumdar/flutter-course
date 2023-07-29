import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharcha/provider/expense_provider.dart';
import 'chart_bar.dart';
import 'package:kharcha/models/expense.dart';

List<ExpenseBucket> buckets(List<Expense> expenses) {
  return [
    ExpenseBucket.forCategory(expenses, Category.drinks),
    ExpenseBucket.forCategory(expenses, Category.electricity),
    ExpenseBucket.forCategory(expenses, Category.food),
    ExpenseBucket.forCategory(expenses, Category.gas),
    ExpenseBucket.forCategory(expenses, Category.gym),
    ExpenseBucket.forCategory(expenses, Category.houseRent),
    ExpenseBucket.forCategory(expenses, Category.internet),
    ExpenseBucket.forCategory(expenses, Category.leisure),
    ExpenseBucket.forCategory(expenses, Category.savings),
    ExpenseBucket.forCategory(expenses, Category.shopping),
    ExpenseBucket.forCategory(expenses, Category.study),
    ExpenseBucket.forCategory(expenses, Category.travel),
    ExpenseBucket.forCategory(expenses, Category.unknown),
    ExpenseBucket.forCategory(expenses, Category.work),
  ];
}

double maxTotalExpense(List<Expense> expenses) {
  double maxTotalExpense = 0;

  for (final bucket in buckets(expenses)) {
    if (bucket.totalExpense > maxTotalExpense) {
      maxTotalExpense = bucket.totalExpense;
    }
  }

  return maxTotalExpense;
}

bool _memoryFlag = true;

class Chart extends ConsumerWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (_memoryFlag) {
      ref.read(expenseProvider.notifier).memoryInitialize();
      _memoryFlag = false;
    }
    final expenses = ref.watch(expenseProvider);
    final dataAvailable = expenses.isNotEmpty;

    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: dataAvailable
          ? Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (final bucket
                          in buckets(expenses)) // alternative to map()
                        ChartBar(
                          fill: bucket.totalExpense == 0
                              ? 0.001
                              : bucket.totalExpense / maxTotalExpense(expenses),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: buckets(expenses)
                      .map(
                        (bucket) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Icon(
                              categoryIcons[bucket.category],
                              color: isDarkMode
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.85),
                              size: 16,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            )
          : Align(
              alignment: Alignment.center,
              child: Text(
                'Chart is not available, Add Kharcha to view chart',
                style: GoogleFonts.comicNeue(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
