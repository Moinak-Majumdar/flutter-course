import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_club/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const initial = UserSchema(name: "", email: "", uid: "", profilePicUrl: "");

class UserNotifier extends StateNotifier<UserSchema> {
  UserNotifier() : super(initial);

  Future<void> setUserById(String uid) async {
    final userSnapShot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userSnapShot.data() != null) {
      final data = userSnapShot.data();
      if (data != null) {
        state = UserSchema(
          name: data['userName'],
          email: data['email'],
          uid: uid,
          profilePicUrl: data['profileImg'],
        );
      }
    }
  }

  void setUserManually(UserSchema user) {
    state = user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserSchema>(
  (ref) => UserNotifier(),
);
