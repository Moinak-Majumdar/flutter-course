import 'package:flutter/material.dart';
import 'package:yumyum/app/models/meal.dart';
import 'package:yumyum/app/widget/meal_card.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(context) {
    Widget content;

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, i) => Container(
          padding: const EdgeInsets.all(16),
          child: MealCard(
            meal: meals[i],
          ),
        ),
      );
    } else {
      content = const NoMeals();
    }

    if (title == null) {
      return content;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content,
      );
    }
  }
}

class NoMeals extends StatelessWidget {
  const NoMeals({super.key});

  @override
  Widget build(context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uh oh, Nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
          const SizedBox(height: 24),
          Text(
            'Try selecting different category or check the active filters.',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );
  }
}
