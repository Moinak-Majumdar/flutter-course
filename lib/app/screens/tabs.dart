import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumyum/app/screens/categories.dart';
import 'package:yumyum/app/screens/filter.dart';
import 'package:yumyum/app/screens/meals.dart';
import 'package:yumyum/app/screens/profile.dart';
import 'package:yumyum/app/widget/main_drawer.dart';
import 'package:yumyum/provider/favorite_provider.dart';
import 'package:yumyum/provider/filters_provider.dart';

const Map<Filter, bool> initialFilter = {};

class TabNavigation extends ConsumerStatefulWidget {
  const TabNavigation({super.key});

  @override
  ConsumerState<TabNavigation> createState() {
    return _TabNavigationState();
  }
}

class _TabNavigationState extends ConsumerState<TabNavigation> {
  int _selectedScreenIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  void _navItemAction(String identifier) {
    // print(identifier);
    Navigator.of(context).pop();
    if (identifier == 'filter') {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(),
        ),
      );
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
    Widget activePage = const CategoriesScreen();

    String activePageTitle = 'Pick your category';

    if (_selectedScreenIndex == 1) {
      final favoriteMeals = ref.watch(favoriteProvider);
      activePageTitle = 'Favorites';
      activePage = MealsScreen(
        meals: favoriteMeals,
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
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
