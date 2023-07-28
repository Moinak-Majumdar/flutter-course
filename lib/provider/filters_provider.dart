import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumyum/app/models/meal.dart';
import 'package:yumyum/provider/favorite_provider.dart';
import 'package:yumyum/provider/meal_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setAllFilters(Map<Filter, bool> allFilters) {
    state = allFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

List<Meal> filterWork(
    {required List<Meal> meals, required ProviderRef<List<Meal>> ref}) {
  final activeFilters = ref.watch(filterProvider);

  return meals.where((meal) {
    if (!meal.isGlutenFree && activeFilters[Filter.glutenFree]!) {
      return false;
    }
    if (!meal.isLactoseFree && activeFilters[Filter.lactoseFree]!) {
      return false;
    }
    if (!meal.isVegan && activeFilters[Filter.vegan]!) {
      return false;
    }
    if (!meal.isVegetarian && activeFilters[Filter.vegetarian]!) {
      return false;
    }
    return true;
  }).toList();
}

final filterMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);

  return filterWork(meals: meals, ref: ref);
});

final filterFavoriteMealsProvider = Provider<List<Meal>>((ref) {
  ref.read(favoriteProvider.notifier).initialFavListMemory();
  final favoriteMeals = ref.watch(favoriteProvider);

  return filterWork(meals: favoriteMeals, ref: ref);
});
