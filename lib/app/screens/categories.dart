import 'package:flutter/material.dart';
import 'package:yumyum/app/data/dummy.dart';
import 'package:yumyum/app/widget/category_card.dart';
import 'package:yumyum/app/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.onToggleFavorite, required this.availableMeal});

  final void Function(Meal m) onToggleFavorite;
  final List<Meal> availableMeal;

  @override
  Widget build(context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 16 / 10,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        ...dummyCategory
            .map((e) => CategoryCard(
                  category: e,
                  onToggleFavorite: onToggleFavorite,
                  availableMeal: availableMeal,
                ))
            .toList(),
      ],
    );
  }
}
