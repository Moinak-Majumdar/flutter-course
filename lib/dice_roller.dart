import 'package:flutter/material.dart';
import 'dart:math';

final randomizer =
    Random(); //hl2 this will prevent to create a new random object every time state is changed.

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  int diceImgState = 1;
  void rollDice() {
    setState(() {
      int genState = randomizer.nextInt(6) + 1;
      if (genState == diceImgState) {
        rollDice();
      } else {
        diceImgState = genState;
      }
    });
  }

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(
          //   'assets/image/dice-$diceImgState.png',
          //   width: 150,
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          TextButton(
            onPressed: rollDice,
            // style: ElevatedButton.styleFrom(
            //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   backgroundColor: Colors.blueGrey,
            //   textStyle: const TextStyle(
            //     fontSize: 20,
            //     fontStyle: FontStyle.italic,
            //   ),
            // ),
            // child: Text('Roll Dice'),
            child: Image.asset(
              'assets/image/dice-$diceImgState.png',
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
