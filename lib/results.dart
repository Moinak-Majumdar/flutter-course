import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:answer_me/utils/icon_button.dart';
import 'package:answer_me/data/qus_library.dart';
import 'package:answer_me/utils/summary.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage(
      {super.key, required this.userAns, required this.changePage});
  final List<String> userAns;
  final void Function(String pageName) changePage;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < qusLibrary.length; i++) {
      summary.add({
        'qus-index': i,
        'question': qusLibrary[i].question,
        'correct-ans': qusLibrary[i].options[0],
        'user-ans': userAns[i]
      });
    }
    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummaryData();
    final totalQus = qusLibrary.length;
    final totalCorrectAns = summaryData.where((elm) {
      return elm['correct-ans'] == elm['user-ans'];
    }).length;

    return SizedBox(
      height: double.infinity,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 80, 0, 40),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(25, 20, 25, 10),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have answered $totalCorrectAns out of $totalQus questions correctly!',
                  style: GoogleFonts.comicNeue(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Summary(data: summaryData),
                const SizedBox(height: 30),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StartIconButton(
                      onTap: () {
                        changePage('start');
                      },
                      label: 'Retake Quiz',
                      icon: const Icon(Icons.restart_alt_rounded),
                      accent: Colors.cyan.shade400,
                    ),
                    StartIconButton(
                      onTap: () {
                        changePage('stop');
                      },
                      label: 'Stop Quiz',
                      icon: const Icon(Icons.stop),
                      accent: Colors.red,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
