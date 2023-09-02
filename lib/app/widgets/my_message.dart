import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
  const MyMessage.firstMessage({super.key, required this.text})
      : isFirstSequence = true;
  const MyMessage.nextMessage({super.key, required this.text})
      : isFirstSequence = false;

  final String text;
  final bool isFirstSequence;

  @override
  Widget build(context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
          constraints: const BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
            color: isFirstSequence
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withAlpha(230),
            borderRadius: BorderRadius.only(
              topRight:
                  isFirstSequence ? Radius.zero : const Radius.circular(12),
              bottomRight: const Radius.circular(12),
              topLeft: const Radius.circular(12),
              bottomLeft: const Radius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
