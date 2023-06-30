import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Summary extends StatelessWidget {
  const Summary({super.key, required this.data});

  final List<Map<String, Object>> data;

  @override
  Widget build(context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...data.map(
            (elm) {
              final String correctAns = elm['correct-ans'] as String;
              final String userAns = elm['user-ans'] as String;
              final isCorrect = (correctAns == userAns) ? true : false;

              return Column(
                children: [
                  DisplayQuestion(
                    isCorrect: isCorrect,
                    qusIndex: ((elm['qus-index'] as int) + 1).toString(),
                    question: elm['question'] as String,
                  ),
                  isCorrect
                      ? CorrectAns(
                          correctAns: correctAns,
                        )
                      : WrongAns(
                          userAns: userAns,
                          correctAns: correctAns,
                        ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class DisplayQuestion extends StatelessWidget {
  const DisplayQuestion(
      {super.key,
      required this.qusIndex,
      required this.question,
      required this.isCorrect});
  final String qusIndex, question;
  final bool isCorrect;

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isCorrect ? Colors.cyan : Colors.pink,
                shape: BoxShape.circle),
            child: Text(
              qusIndex,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              question,
              style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}

class CorrectAns extends StatelessWidget {
  const CorrectAns({super.key, required this.correctAns});
  final String correctAns;

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.only(bottom: 10, left: 10),
      child: Row(
        children: [
          Icon(
            Icons.add_task_rounded,
            color: Colors.teal.shade400,
            size: 32,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              correctAns,
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.teal),
            ),
          )
        ],
      ),
    );
  }
}

class WrongAns extends StatelessWidget {
  const WrongAns({super.key, required this.correctAns, required this.userAns});
  final String userAns, correctAns;

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.only(bottom: 10, left: 10),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.close_outlined,
                color: Colors.red.shade500,
                size: 32,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  userAns,
                  style: GoogleFonts.roboto(fontSize: 18, color: Colors.red),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.add_task_rounded,
                color: Colors.teal.shade400,
                size: 32,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  correctAns,
                  style: GoogleFonts.roboto(fontSize: 18, color: Colors.teal),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
