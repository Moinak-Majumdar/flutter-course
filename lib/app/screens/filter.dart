import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumyum/provider/filters_provider.dart';

class FilterScreen extends ConsumerWidget {
  @override
  Widget build(context, WidgetRef ref) {
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
    // hl2 provider filters map
    final activeFilter = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilter[Filter.glutenFree]!,
            onChanged: (value) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.glutenFree, value);
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
            value: activeFilter[Filter.lactoseFree]!,
            onChanged: (value) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.lactoseFree, value);
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
            value: activeFilter[Filter.vegan]!,
            onChanged: (value) {
              ref.read(filterProvider.notifier).setFilter(Filter.vegan, value);
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
            value: activeFilter[Filter.vegetarian]!,
            onChanged: (value) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegetarian, value);
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
    );
  }
}
