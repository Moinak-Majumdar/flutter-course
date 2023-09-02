import 'package:fire_club/app/screens/chat.dart';
import 'package:fire_club/app/screens/landing.dart';
import 'package:fire_club/app/screens/splash.dart';
import 'package:fire_club/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(context, WidgetRef providerRef) {
    Future<void> futureProvider(String uid) async {
      await providerRef.read(userProvider.notifier).setUserById(uid);
    }

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        if (snapshot.hasData) {
          final uid = snapshot.data!.uid;

          return FutureBuilder(
            future: futureProvider(uid),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              return const ChatScreen();
            }),
          );
        }
        return const Landing();
      },
    );
  }
}
