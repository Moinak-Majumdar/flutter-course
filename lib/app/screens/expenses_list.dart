import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kharcha/app/widget/expense_list_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharcha/provider/expense_provider.dart';

class ExpensesList extends ConsumerStatefulWidget {
  const ExpensesList({super.key});

  @override
  ConsumerState<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends ConsumerState<ExpensesList> {
  late Future<void> _futureProvider;

  @override
  void initState() {
    _futureProvider = ref.read(expenseProvider.notifier).getMemoryItem();
    super.initState();
  }

  @override
  Widget build(context) {
    final expenseList = ref.watch(expenseProvider);

    return FutureBuilder(
      future: _futureProvider,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (expenseList.isEmpty) {
          return const NoItems();
        }
        return ListView.builder(
          itemCount: expenseList.length,
          itemBuilder: (ctx, index) =>
              ExpenseListItem(expense: expenseList[index]),
        );
      },
    );
  }
}

class NoItems extends StatelessWidget {
  const NoItems({super.key});

  @override
  Widget build(context) {
    return SizedBox(
      height: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'No kharcha is found, Try adding some!',
            style: GoogleFonts.comicNeue(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
