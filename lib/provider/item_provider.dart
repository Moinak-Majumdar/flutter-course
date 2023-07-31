import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/model/category.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceryListNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryListNotifier() : super([]);

  void loadBackEnd(List<GroceryItem> gi) async {
    state = gi;
  }

  void addGroceryItem({
    required String name,
    required int quantity,
    required Category category,
  }) async {
    final url = Uri.https(dotenv.env['FIREBASE_URI']!, 'shopping-list.json');

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {'name': name, 'quantity': quantity, 'category': category.name},
      ),
    );
    final resData = jsonDecode(res.body);
    state = [
      ...state,
      GroceryItem(
        id: resData['name'],
        name: name,
        quantity: quantity,
        category: category,
      )
    ];
  }

  void deleteGroceryItem(GroceryItem gi) {
    final url =
        Uri.https(dotenv.env['FIREBASE_URI']!, 'shopping-list/${gi.id}.json');
    http.delete(
        url); //not waiting for server response to delete from locally, thats why no await.
    state = state.where((element) => element.id != gi.id).toList();
  }
}

final groceryListProvider =
    StateNotifierProvider<GroceryListNotifier, List<GroceryItem>>(
  (ref) => GroceryListNotifier(),
);
