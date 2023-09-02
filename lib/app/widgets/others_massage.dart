import 'package:flutter/material.dart';

final colorList = [
  Colors.red[700],
  Colors.lightGreen,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.teal,
  Colors.amber,
  Colors.indigo,
  Colors.pink
];

class OthersMessages extends StatelessWidget {
  const OthersMessages.firstMessage({
    super.key,
    required this.text,
    required this.userName,
    required this.profileImgUrl,
    required this.email,
  }) : isFirstSequence = true;

  const OthersMessages.nextMessage({
    super.key,
    required this.text,
  })  : isFirstSequence = false,
        userName = null,
        profileImgUrl = null,
        email = null;

  final String text;
  final bool isFirstSequence;
  final String? userName;
  final String? profileImgUrl;
  final String? email;

  void showUserInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('~ ${userName!}'),
        content: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(profileImgUrl!),
            ),
            const SizedBox(width: 14),
            Text(email!),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (isFirstSequence)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              InkWell(
                onTap: () {
                  showUserInfo(context);
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(profileImgUrl!),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '~ ${userName!}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: (colorList..shuffle()).first,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Container(
                constraints: const BoxConstraints(maxWidth: 300),
                margin: const EdgeInsets.only(bottom: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.zero,
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: Theme.of(context).colorScheme.secondary.withAlpha(230),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        if (!isFirstSequence)
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: Theme.of(context).colorScheme.secondary.withAlpha(200),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        const Spacer(),
      ],
    );
  }
}
