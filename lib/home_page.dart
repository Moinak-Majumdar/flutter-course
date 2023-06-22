import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openApp() {
    print('Opening');
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/quiz-logo.png',
          color: const Color.fromARGB(150, 255, 255, 255),
          width: 250,
        ),
        const SizedBox(
          height: 50,
        ),
        const Text(
          'Learn Flutter the fun way.',
          style: TextStyle(
              fontSize: 25, color: Colors.white70, fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          height: 30,
        ),
        OutlinedButton(
          onPressed: openApp,
          style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromARGB(215, 255, 255, 255),
              shadowColor: Colors.blueGrey),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Start Quiz',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(Icons.arrow_right_alt),
            ],
          ),
        )
      ],
    );
  }
}
