import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:yumyum/app/models/meal.dart';
import 'package:yumyum/app/screens/meal_details.dart';
import 'package:yumyum/app/widget/icon_with_text.dart';

class MealCard extends StatelessWidget {
  const MealCard(
      {super.key, required this.meal, required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal m) onToggleFavorite;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  void _pageChanger(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetails(
          meal: meal,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return InkWell(
      onTap: () {
        _pageChanger(context);
      },
      borderRadius: BorderRadius.circular(16),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconWithText(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        IconWithText(
                          icon: Icons.redo,
                          label: complexityText,
                        ),
                        IconWithText(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
