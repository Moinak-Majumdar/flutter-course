import 'package:fire_club/app/screens/update_profile.dart';
import 'package:fire_club/app/widgets/chat_messages.dart';
import 'package:fire_club/app/widgets/new_message.dart';
import 'package:fire_club/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(context, ref) {
    final currentUser = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fire Club 🔥🔥'),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(),
        width: 250,
        child: Column(
          children: [
            Container(
              width: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.primary,
                  ],
                ),
              ),
              padding: const EdgeInsets.only(
                top: 70,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: currentUser.profilePicUrl,
                      height: 130,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '~ ${currentUser.name}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentUser.email,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.update,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
              tileColor: Theme.of(context).colorScheme.primaryContainer,
              title: const Text('Update Profile'),
              titleTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 22),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const UpdateProfile(),
                  ),
                );
              },
            ),
            const Spacer(),
            ListTile(
              leading: Icon(
                Icons.exit_to_app_rounded,
                color: Theme.of(context).colorScheme.error,
                size: 32,
              ),
              tileColor: Theme.of(context).colorScheme.errorContainer,
              title: const Text('Sign Out'),
              titleTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.error, fontSize: 22),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
    );
  }
}
