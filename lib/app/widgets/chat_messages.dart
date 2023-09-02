import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_club/app/widgets/my_message.dart';
import 'package:fire_club/app/widgets/others_massage.dart';
import 'package:fire_club/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessages extends ConsumerWidget {
  const ChatMessages({super.key});

  @override
  Widget build(context, WidgetRef widgetRef) {
    final currentUser = widgetRef.watch(userProvider);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "No messages to show..",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          );
        }
        if (chatSnapshot.hasError) {
          return const Center(
            child: Text(
              "Something went wrong..",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          );
        }
        final loadedMessages = chatSnapshot.data!.docs;
        String? previousUserId;
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final data = loadedMessages[index].data();
            final currentMessengerId = data['uid'];

            final nextUserIsSame = currentMessengerId == previousUserId;

            final isMe = currentUser.uid == currentMessengerId;

            if (nextUserIsSame) {
              previousUserId = currentMessengerId;
              return isMe
                  ? MyMessage.nextMessage(text: data['text'])
                  : OthersMessages.nextMessage(text: data['text']);
            } else {
              previousUserId = currentMessengerId;
              return isMe
                  ? MyMessage.firstMessage(text: data['text'])
                  : OthersMessages.firstMessage(
                      text: data['text'],
                      userName: data['userName'],
                      profileImgUrl: data['userImg'],
                      email: data['email'],
                    );
            }
          },
        );
      },
    );
  }
}
