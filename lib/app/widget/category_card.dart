import 'package:flutter/material.dart';
import 'package:yumyum/app/models/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final Category category;
  @override
  Widget build(context) {
    return const Text('Stateless');
  }
}
