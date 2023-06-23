import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({super.key, required this.option, required this.onTap});

  final String option;
  final void Function() onTap;

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          backgroundColor: Color.fromARGB(255, 33, 1, 95),
          foregroundColor: Colors.white70,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
        ),
        child: Text(
          option,
          style: GoogleFonts.ubuntu(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
