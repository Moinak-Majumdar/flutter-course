import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_club/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewMessage extends ConsumerStatefulWidget {
  const NewMessage({super.key});

  @override
  ConsumerState<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends ConsumerState<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final msg = _messageController.text;

    if (msg.trim().isEmpty) {
      return;
    }
    //  close keyboard
    FocusScope.of(context).unfocus();
    _messageController.clear();

    final userData = ref.read(userProvider);

    FirebaseFirestore.instance.collection('chat').add({
      'text': msg,
      'createdAt': Timestamp.now(),
      'uid': userData.uid,
      'userName': userData.name,
      'userImg': userData.profilePicUrl,
      'email': userData.email,
    });
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 2, bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 3),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: 'Message', border: InputBorder.none),
                  controller: _messageController,
                  autocorrect: true,
                  enableSuggestions: true,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send),
            alignment: Alignment.center,
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primary,
              ),
              iconColor: const MaterialStatePropertyAll(Colors.white),
              iconSize: const MaterialStatePropertyAll(24),
            ),
          )
        ],
      ),
    );
  }
}
