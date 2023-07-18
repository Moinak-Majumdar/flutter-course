import 'package:flutter/material.dart';
import 'package:yumyum/app/data/dummy.dart';
import 'package:yumyum/app/models/category.dart';
// import 'package:yumyum/app/models/meal.dart';
import 'package:yumyum/app/screens/meals.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final Category category;

  void _pageChanger(BuildContext context) {
    final filterMeals = dummyMeals
        .where((element) => element.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Meals(title: category.title, meals: filterMeals),
      ),
    );
  }

  @override
  Widget build(context) {
    return InkWell(
      onTap: () {
        _pageChanger(context);
      },
      splashColor: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
