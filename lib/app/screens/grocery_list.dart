import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/app/widget/grocery_card.dart';
import 'package:shopping_list/provider/item_provider.dart';

class GroceryList extends ConsumerWidget {
  const GroceryList({super.key});

  @override
  Widget build(context, WidgetRef ref) {
    final groceryList = ref.watch(groceryListProvider);
    return groceryList.isNotEmpty
        ? ListView.builder(
            itemCount: groceryList.length,
            itemBuilder: (ctx, index) =>
                GroceryCard(groceryItem: groceryList[index]),
          )
        : const NoItem();
  }
}

class NoItem extends StatelessWidget {
  const NoItem({super.key});

  @override
  Widget build(context) {
    return Center(
      child: Text(
        'You got no items yet.',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
    );
  }
}
