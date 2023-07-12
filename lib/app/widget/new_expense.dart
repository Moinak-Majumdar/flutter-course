import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharcha/models/expense.dart';
import 'alerts.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense e) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  DateTime? _date;
  Category _selectedCategory = Category.unknown;

  void _pickDate(DateTime now) {
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(today.year - 1, today.month, today.day),
      lastDate: today,
    ).then((value) {
      setState(() {
        _date = value;
      });
    });
  }

  void changeCategory(Category values) {
    setState(() {
      _selectedCategory = values;
    });
  }

  void handelSubmit() {
    // form validation
    final enteredAmount = double.tryParse(_amount.text);
    final validAmount = enteredAmount == null || enteredAmount <= 0;
    final validDate = _date == null;
    final validTitle = _title.text.trim().isEmpty;

    if (validAmount || validDate || validTitle) {
      showDialog(
        context: context,
        builder: (ctx) => FailedAlert(buildCtx: ctx),
      );
      return;
    } else {
      widget.onAddExpense(
        Expense(
          amount: enteredAmount,
          date: _date!,
          title: _title.text,
          category: _selectedCategory,
        ),
      );
      showDialog(
        context: context,
        builder: (ctx) => SuccessAlert(buildCtx: ctx),
      ).then((value) {
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
      child: Column(
        children: [
          GetTitle(titleController: _title),
          Row(
            children: [
              GetDate(date: _date, datePicker: _pickDate),
              const SizedBox(width: 16),
              GetAmount(amountController: _amount)
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              PickCategory(
                selectedCategory: _selectedCategory,
                changeCategory: changeCategory,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: handelSubmit,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// hl4 utility classes

class GetTitle extends StatelessWidget {
  const GetTitle({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Expense short description.',
          hintStyle: Theme.of(context).textTheme.bodySmall,
          label: const Text('Title'),
          // border: OutlineInputBorder(),
        ),
        maxLength: 50,
        controller: titleController,
      ),
    );
  }
}

class GetDate extends StatelessWidget {
  const GetDate({super.key, required this.date, required this.datePicker});

  final DateTime? date;
  final void Function(DateTime d) datePicker;

  @override
  Widget build(context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Text(
              date == null
                  ? 'No date selected'
                  : dateFormat(
                      date!,
                      fullDay: true,
                    ),
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              date != null ? datePicker(date!) : datePicker(today);
            },
            icon: const Icon(
              Icons.calendar_month_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class GetAmount extends StatelessWidget {
  const GetAmount({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          label: const Text('Amount'),
          border: const OutlineInputBorder(),
          helperText: 'Amount you have spend.',
          helperStyle: Theme.of(context).textTheme.bodySmall,
          prefixText: '₹ ',
        ),
        keyboardType: TextInputType.number,
        controller: amountController,
      ),
    );
  }
}

class PickCategory extends StatelessWidget {
  const PickCategory({
    super.key,
    required this.selectedCategory,
    required this.changeCategory,
  });

  final Category selectedCategory;
  final void Function(Category v) changeCategory;

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select category',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        DropdownButton(
          value: selectedCategory,
          items: Category.values
              .map(
                (e) => DropdownMenuItem(
                    value: e,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          e.name.toUpperCase(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          categoryIcons[e],
                          color: Theme.of(context).iconTheme.color,
                          size: 16,
                        ),
                      ],
                    )),
              )
              .toList(),
          onChanged: (values) {
            if (values != null) {
              changeCategory(values);
            }
          },
        ),
      ],
    );
  }
}
