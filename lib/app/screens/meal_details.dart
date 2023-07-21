import 'package:flutter/material.dart';
import 'package:yumyum/app/models/meal.dart';

class MealDetails extends StatelessWidget {
  const MealDetails(
      {super.key, required this.meal, required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal m) onToggleFavorite;

  @override
  Widget build(context) {
    final TextStyle titleLarge =
        Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            );
    final TextStyle bodyLarge = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              onToggleFavorite(meal);
            },
            icon: const Icon(Icons.star_border_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  meal.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Ingredients :',
                style: titleLarge,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  meal.ingredientsOneLineText,
                  style: bodyLarge,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Steps :',
                style: titleLarge,
              ),
              const SizedBox(height: 8),
              for (int i = 0; i < meal.steps.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${i + 1}.  ${meal.steps[i]}.',
                    style: bodyLarge,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
