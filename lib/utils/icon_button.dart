import 'package:flutter/material.dart';

class StartIconButton extends StatelessWidget {
  const StartIconButton(
      {super.key,
      required this.onTap,
      required this.label,
      required this.icon,
      required this.accent});

  final void Function() onTap;
  final String label;
  final Widget icon;
  final Color accent;

  @override
  Widget build(context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        side: BorderSide(color: accent),
      ),
      icon: icon,
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
