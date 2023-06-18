import 'package:flutter/material.dart';
import 'package:roll_a_dice/gradient_container.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return const MaterialApp(
      home: Scaffold(
        body: GradientContainer([Colors.red, Colors.white, Colors.blue]),
      ),
    );
  }
}
