import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kharcha/app/widget/no_date_alert.dart';
import 'package:kharcha/models/expense.dart';
import 'package:kharcha/provider/expense_provider.dart';

class NewExpense extends ConsumerStatefulWidget {
  const NewExpense({super.key});

  @override
  ConsumerState<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends ConsumerState<NewExpense> {
  final _formKey = GlobalKey<FormState>();
  Category? _selectedCategory;
  IconData _currentCategoryIcon = Icons.label;
  String? _enteredTitle;
  double? _enteredAmount;
  DateTime? _enteredDate;

  void _pickDate(DateTime now) {
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(today.year - 1, today.month, today.day),
      lastDate: today,
    ).then((value) {
      setState(() {
        _enteredDate = value;
      });
    });
  }

  void handelSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_enteredDate == null) {
        showDialog(
          context: context,
          builder: (ctx) => NoDateAlert(
            onDatePick: _pickDate,
            buildContext: ctx,
          ),
        );
        return;
      }

      ref.read(expenseProvider.notifier).addExpense(
            Expense(
              amount: double.tryParse(_enteredAmount.toString())!,
              date: _enteredDate!,
              title: _enteredTitle!,
              category: _selectedCategory!,
            ),
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Expense',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: 26,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //hl4 picking title.
              TextFormField(
                decoration: InputDecoration(
                  label: Text(
                    'Title',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  hintText: 'Expense short description.',
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                ),
                maxLength: 50,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Required *';
                  }
                  if (val.trim().length < 4 || val.trim().length > 50) {
                    return 'Entered text must be between 4 to 50 characters long.';
                  }
                  return null;
                },
                onSaved: (val) {
                  _enteredTitle = val;
                },
              ),
              // hl2 picking date and amount.
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        _enteredDate != null
                            ? _pickDate(_enteredDate!)
                            : _pickDate(today);
                      },
                      icon: const Icon(Icons.calendar_month_rounded),
                      label: Text(
                        _enteredDate == null
                            ? 'No date selected.'
                            : dateFormat(
                                _enteredDate!,
                                fullDay: true,
                              ),
                      ),
                    ),
                  ),
                  // hl7 entering amount.
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                          'Amount',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        helperText: 'Amount you have spend.',
                        helperStyle:
                            Theme.of(context).inputDecorationTheme.helperStyle,
                        prefixText: '₹ ',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Required *';
                        }
                        if (double.tryParse(val)! <= 0) {
                          return 'Enter valid positive integer.';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _enteredAmount = double.parse(val!);
                      },
                    ),
                  ),
                ],
              ),
              // hl3 Select category.
              const SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    icon: Icon(_currentCategoryIcon),
                    iconColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'Category',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    hintText: 'Select the type of your expense.',
                    hintStyle:
                        Theme.of(context).inputDecorationTheme.hintStyle),
                validator: (val) {
                  if (val == null) {
                    return 'Required *';
                  }
                  return null;
                },
                onSaved: (val) {
                  _selectedCategory = val;
                },
                onChanged: (e) {
                  setState(() {
                    _currentCategoryIcon = categoryIcons[e]!;
                  });
                },
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 4),
                          child: Text(
                            e.name.toUpperCase(),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              // hl5 submit and reset.
              const SizedBox(height: 40),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                      setState(() {
                        _currentCategoryIcon = Icons.label;
                      });
                    },
                    child: const Text('RESET'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: handelSubmit,
                    child: const Text('SUBMIT'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
