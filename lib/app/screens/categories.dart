import 'package:flutter/material.dart';
import 'package:yumyum/app/data/dummy.dart';
import 'package:yumyum/app/widget/category_card.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 10,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          ...dummyCategory.map((e) => CategoryCard(category: e)).toList(),
        ],
      ),
    );
  }
}
