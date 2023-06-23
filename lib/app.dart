import 'package:flutter/material.dart';
import 'package:answer_me/landing.dart';
import 'package:answer_me/questions.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  Widget? currentPage;
  @override
  void initState() {
    currentPage = Landing(changePage);
    super.initState();
  }

  void changePage() {
    setState(() {
      currentPage = const Questions();
    });
  }

  @override
  Widget build(context) {
    return Center(
      child: currentPage,
    );
  }
}
