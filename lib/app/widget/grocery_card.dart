import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:shopping_list/provider/item_provider.dart';

class GroceryCard extends ConsumerWidget {
  const GroceryCard({super.key, required this.groceryItem});
  final GroceryItem groceryItem;

  @override
  Widget build(context, ref) {
    return Dismissible(
      key: ValueKey(groceryItem),
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Confirmation',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          content:
              Text('Do you want to delete this item : ${groceryItem.name}?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary),
              child: Text(
                'CANCEL',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(groceryListProvider.notifier)
                    .deleteGroceryItem(groceryItem);
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error),
              child: Text(
                'DELETE',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onError,
                    ),
              ),
            )
          ],
        ),
      ),
      child: ListTile(
        title: Text(
          groceryItem.name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
        ),
        leading: Container(
          height: 24,
          width: 24,
          color: groceryItem.category.color,
        ),
        trailing: Text(
          groceryItem.quantity.toString(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: groceryItem.category.color,
              ),
        ),
      ),
    );
  }
}
