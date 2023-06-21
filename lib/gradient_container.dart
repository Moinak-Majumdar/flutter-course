import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final List<Color> colorList;
  const GradientContainer(this.colorList, {super.key});

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colorList,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Text('Hello Flutter!'),
      ),
    );
  }
}

//hl6 copy this to use the class =>              
//  GradientContainer([Colors.red, Colors.white, Colors.blue],),