import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: const [
            Text(
              'hahaha',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'hahaha',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'hahaha',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'hahaha',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'hahaha',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'hahaha',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
