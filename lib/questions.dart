import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:answer_me/utils/option_button.dart';
import 'package:answer_me/data/qus_library.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({required this.onSelectAns, super.key});

  final void Function(String ans) onSelectAns;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var qusIndex = 0;
  void userAns(String choice) {
    widget.onSelectAns(choice);
    setState(() {
      qusIndex++;
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
            'Question : ${qusIndex + 1}',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            currentQus.question,
            style: GoogleFonts.comicNeue(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          ...currentQus.shuffledOptions().map(
            (option) {
              return OptionButton(
                option: option,
                onTap: () {
                  userAns(option);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
