import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumyum/app/models/meal.dart';

class FavoriteNotifier extends StateNotifier<List<Meal>> {
  FavoriteNotifier() : super([]);

  bool toggleFavorite(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List<Meal>>(
  (ref) => FavoriteNotifier(),
);
