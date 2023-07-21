import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});
  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isGlutenFree = widget.currentFilters[Filter.glutenFree]!;
    _isLactoseFree = widget.currentFilters[Filter.lactoseFree]!;
    _isVegetarian = widget.currentFilters[Filter.vegetarian]!;
    _isVegan = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(context) {
    final Color activeColor = Theme.of(context).colorScheme.tertiary;
    final TextStyle titleStyle =
        Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            );
    final TextStyle subTitleStyle =
        Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            );
    const switchPadding = EdgeInsets.only(left: 44, right: 22);

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop({
          Filter.glutenFree: _isGlutenFree,
          Filter.lactoseFree: _isLactoseFree,
          Filter.vegan: _isVegan,
          Filter.vegetarian: _isVegetarian,
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Filters'),
        ),
        body: Column(
          children: [
            SwitchListTile(
              value: _isGlutenFree,
              onChanged: (value) {
                setState(() {
                  _isGlutenFree = value;
                });
              },
              activeColor: activeColor,
              title: Text(
                'Gluten Free',
                style: titleStyle,
              ),
              subtitle: Text(
                'Only include gluten free meals.',
                style: subTitleStyle,
              ),
              contentPadding: switchPadding,
            ),
            SwitchListTile(
              value: _isLactoseFree,
              onChanged: (value) {
                setState(() {
                  _isLactoseFree = value;
                });
              },
              activeColor: activeColor,
              title: Text(
                'Lactose Free',
                style: titleStyle,
              ),
              subtitle: Text(
                'Only include lactose free meals.',
                style: subTitleStyle,
              ),
              contentPadding: switchPadding,
            ),
            SwitchListTile(
              value: _isVegan,
              onChanged: (value) {
                setState(() {
                  _isVegan = value;
                });
              },
              activeColor: activeColor,
              title: Text(
                'Vegan',
                style: titleStyle,
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: subTitleStyle,
              ),
              contentPadding: switchPadding,
            ),
            SwitchListTile(
              value: _isVegetarian,
              onChanged: (value) {
                setState(() {
                  _isVegetarian = value;
                });
              },
              activeColor: activeColor,
              title: Text(
                'Vegetarian',
                style: titleStyle,
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: subTitleStyle,
              ),
              contentPadding: switchPadding,
            ),
          ],
        ),
      ),
    );
  }
}
