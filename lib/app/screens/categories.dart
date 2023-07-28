import 'package:flutter/material.dart';
import 'package:yumyum/app/data/dummy.dart';
import 'package:yumyum/app/widget/category_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController1;
  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 1200),
    );
    _animationController1.forward();
  }

  @override
  void dispose() {
    _animationController1.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return AnimatedBuilder(
      animation: _animationController1,
      child: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 10,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final elm in dummyCategory) CategoryCard(category: elm)
        ],
      ),
      builder: (ctx, child) => FadeTransition(
        opacity: CurvedAnimation(
            parent: _animationController1, curve: Curves.easeIn),
        child: child,
      ),
    );
  }
}
