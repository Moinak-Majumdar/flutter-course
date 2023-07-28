import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumyum/app/models/meal.dart';
import 'package:yumyum/provider/favorite_provider.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(context, WidgetRef ref) {
    final TextStyle titleLarge =
        Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            );
    final TextStyle bodyLarge = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        );
    // hl3 favorite meals provider
    final isFavorite = ref.watch(favoriteProvider).contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded =
                  ref.read(favoriteProvider.notifier).toggleFavorite(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded
                        ? 'Meal added as favorite.'
                        : 'Meal is no longer favorite.',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border_outlined,
                key: ValueKey(isFavorite),
              ),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                child: child,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: meal.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    meal.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
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
