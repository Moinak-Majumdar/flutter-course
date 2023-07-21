import 'package:flutter/material.dart';
import 'package:yumyum/app/data/dummy.dart';
import 'package:yumyum/app/models/meal.dart';
import 'package:yumyum/app/screens/categories.dart';
import 'package:yumyum/app/screens/filter.dart';
import 'package:yumyum/app/screens/meals.dart';
import 'package:yumyum/app/screens/profile.dart';
import 'package:yumyum/app/widget/main_drawer.dart';

void _showInfoMsg(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
    ),
  );
}

const Map<Filter, bool> initialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabNavigation extends StatefulWidget {
  const TabNavigation({super.key});

  @override
  State<TabNavigation> createState() {
    return _TabNavigationState();
  }
}

class _TabNavigationState extends State<TabNavigation> {
  int _selectedScreenIndex = 0;
  final List<Meal> _favoriteMeal = [];
  Map<Filter, bool> _selectedFilters = initialFilter;

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeal.remove(meal);
        _showInfoMsg('Meal is no longer favorite.', context);
      });
    } else {
      setState(() {
        _favoriteMeal.add(meal);
        _showInfoMsg('Meal is added to favorite!', context);
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  void _navItemAction(String identifier) async {
    // print(identifier);
    Navigator.of(context).pop();
    if (identifier == 'filter') {
      final response = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(currentFilters: _selectedFilters),
        ),
      );

      setState(() {
        _selectedFilters = response ?? initialFilter;
      });
    }
    if (identifier == 'profile') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const Profile(),
        ),
      );
    }
  }

  @override
  Widget build(context) {
    final availableMealWithFilter = dummyMeals.where((meal) {
      if (!meal.isGlutenFree && _selectedFilters[Filter.glutenFree]!) {
        return false;
      }
      if (!meal.isLactoseFree && _selectedFilters[Filter.lactoseFree]!) {
        return false;
      }
      if (!meal.isVegan && _selectedFilters[Filter.vegan]!) {
        return false;
      }
      if (!meal.isVegetarian && _selectedFilters[Filter.vegetarian]!) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeal: availableMealWithFilter,
    );

    String activePageTitle = 'Pick your category';

    if (_selectedScreenIndex == 1) {
      activePageTitle = 'Favorites';
      activePage = MealsScreen(
        meals: _favoriteMeal,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: MainDrawer(onNavItemAction: _navItemAction),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedScreenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
