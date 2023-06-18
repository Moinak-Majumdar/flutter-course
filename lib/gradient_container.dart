import 'package:flutter/material.dart';
import 'package:roll_a_dice/dice_roller.dart';

class GradientContainer extends StatelessWidget {
  final List<Color> colorList;

  const GradientContainer(this.colorList, {super.key});
  // or
  // const GradientContainer({key}) : super(key: key);

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
      child: const DiceRoller(),
    );
  }
}
