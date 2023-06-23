import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:answer_me/utils/option_button.dart';
import 'package:answer_me/data/qus_library.dart';

class Questions extends StatelessWidget {
  const Questions({super.key});

  @override
  Widget build(context) {
    return const QuestionScreen();
  }
}

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var qusIndex = 0;
  void userAns() {
    setState(() {
      if (qusIndex >= qusLibrary.length) {
        qusIndex = 0;
      } else {
        qusIndex++;
      }
    });
  }

  @override
  Widget build(context) {
    final currentQus = qusLibrary[qusIndex];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            currentQus.question,
            style: GoogleFonts.comicNeue(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          ...currentQus.shuffledOptions().map((curr) {
            return OptionButton(option: curr, onTap: userAns);
          })
        ],
      ),
    );
  }
}
