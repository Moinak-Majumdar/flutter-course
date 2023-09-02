import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_club/app/widgets/user_image_update.dart';
import 'package:fire_club/model/user.dart';
import 'package:fire_club/provider/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProfile extends ConsumerStatefulWidget {
  const UpdateProfile({super.key});

  @override
  ConsumerState<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends ConsumerState<UpdateProfile> {
  static final _formKey = GlobalKey<FormState>();
  late UserSchema _currentUser;
  String _enteredUserName = '';
  File? _selectedImg;
  bool isLoading = false;

  @override
  void initState() {
    final user = ref.read(userProvider);
    _currentUser = user;
    super.initState();
  }

  void showSnackAlert(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void handelSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      isLoading = true;
    });

    try {
      if (_selectedImg == null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_currentUser.uid)
            .update(
          {
            "userName": _enteredUserName,
            "email": _currentUser.email,
            "profileImg": _currentUser.profilePicUrl
          },
        );
        ref.read(userProvider.notifier).setUserManually(
              UserSchema(
                name: _enteredUserName,
                email: _currentUser.email,
                uid: _currentUser.uid,
                profilePicUrl: _currentUser.profilePicUrl,
              ),
            );
        showSnackAlert('Profile Updated...');
      } else {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('userProfileImage')
            .child('${_currentUser.uid}.jpg');
        await storageRef.putFile(_selectedImg!);
        final imgUrl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_currentUser.uid)
            .set(
          {
            'userName': _enteredUserName,
            "email": _currentUser.email,
            'profileImg': imgUrl,
          },
        );
        ref.read(userProvider.notifier).setUserManually(
              UserSchema(
                name: _enteredUserName,
                email: _currentUser.email,
                uid: _currentUser.uid,
                profilePicUrl: imgUrl,
              ),
            );
        showSnackAlert('Profile Updated...');
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackAlert('Profile update Error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Profile',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    UserImageUpdate(
                      onPickImage: (pickedImg) {
                        _selectedImg = pickedImg;
                      },
                      prevImgUrl: _currentUser.profilePicUrl,
                    ),
                    TextFormField(
                      initialValue: _currentUser.name,
                      decoration: const InputDecoration(labelText: 'User name'),
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        return _userNameValidator(val);
                      },
                      onSaved: (val) {
                        _enteredUserName = val!;
                      },
                    ),
                    const SizedBox(height: 24),
                    if (isLoading)
                      Container(
                        width: 240,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Saving Data ..',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            const SizedBox(width: 20),
                            Transform.scale(
                              scale: 0.6,
                              child: const CircularProgressIndicator(
                                  color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    if (!isLoading)
                      ElevatedButton(
                        onPressed: handelSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.background,
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String? _userNameValidator(String? val) {
  if (val == null || val.trim().isEmpty) {
    return 'Required *';
  }
  if (val.length < 4) {
    return 'Username at least have 4 characters.';
  }
  return null;
}
