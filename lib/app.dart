import 'package:flutter/material.dart';
import 'package:answer_me/landing.dart';
import 'package:answer_me/questions.dart';
import 'package:answer_me/data/qus_library.dart';
import 'package:answer_me/results.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  String pageIdentifier = 'landing-page';
  List<String> userAnsList = [];

  void changePage(String pageName) {
    setState(() {
      if (pageName == 'start') {
        userAnsList = [];
        pageIdentifier = 'questions-page';
      }
      if (pageName == 'stop') {
        userAnsList = [];
        pageIdentifier = 'landing-page';
      }
    });
  }

  void addAns(String ans) {
    userAnsList.add(ans);
    if (userAnsList.length == qusLibrary.length) {
      setState(() {
        pageIdentifier = 'result-page';
      });
    }
  }

  @override
  Widget build(context) {
    Widget? currentPage;

    switch (pageIdentifier) {
      case 'landing-page':
        currentPage = Landing(changePage);
        break;
      case 'questions-page':
        currentPage = QuestionScreen(onSelectAns: addAns);
        break;
      case 'result-page':
        currentPage = ResultsPage(
          userAns: userAnsList,
          changePage: changePage,
        );
        break;
      default:
        currentPage = Landing(changePage);
    }

    return Center(
      child: currentPage,
    );
  }
}
