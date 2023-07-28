import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yumyum/app/data/dummy.dart';
import 'package:yumyum/app/models/meal.dart';

void manipulateFavoriteMealsMemory(List<Meal> meals) async {
  final pref = await SharedPreferences.getInstance();
  final List<String> favList = [];

  for (final meal in meals) {
    favList.add(meal.id);
  }

  await pref.setStringList('favList', favList);
  print(favList);
}

class FavoriteNotifier extends StateNotifier<List<Meal>> {
  FavoriteNotifier() : super([]);

  void initialFavListMemory() async {
    final pref = await SharedPreferences.getInstance();
    final memoryData = pref.getStringList('favList');

    final List<Meal> favList = [];
    if (memoryData != null || memoryData!.isNotEmpty) {
      for (final meal in dummyMeals) {
        for (final e in memoryData) {
          if (e == meal.id) {
            favList.add(meal);
          }
        }
      }
    }
    state = [...favList];
  }

  bool toggleFavorite(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      manipulateFavoriteMealsMemory(state);
      return false;
    } else {
      state = [...state, meal];
      manipulateFavoriteMealsMemory(state);
      return true;
    }
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List<Meal>>(
  (ref) => FavoriteNotifier(),
);
