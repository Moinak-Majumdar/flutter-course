import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/provider/item_provider.dart';

final networkDataProvider = Provider<Future<List<GroceryItem>>>((ref) async {
  try {
    final url = Uri.https(dotenv.env['FIREBASE_URI']!, 'shopping-list.json');
    final res = await http.get(url);
    if (res.statusCode >= 400) {
      throw Exception('Failed to fetch data, Please try again later.');
    }
    final Map<String, dynamic>? resData = jsonDecode(res.body);
    final List<GroceryItem> loadedItems = [];
    if (resData == null) {
      ref.watch(groceryListProvider.notifier).loadBackEnd(loadedItems);
      return loadedItems;
    }

    for (final data in resData.entries) {
      loadedItems.add(
        GroceryItem(
          id: data.key,
          name: data.value['name'],
          quantity: data.value['quantity'],
          category: categories.entries
              .firstWhere(
                  (element) => element.value.name == data.value['category'])
              .value,
        ),
      );
    }
    ref.watch(groceryListProvider.notifier).loadBackEnd(loadedItems);
    return loadedItems;
  } catch (err) {
    throw Exception('Something went wrong, Please restart the app.');
  }
});
