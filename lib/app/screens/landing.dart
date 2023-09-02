import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_club/app/widgets/user_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebaseAuth = FirebaseAuth.instance;

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  static final _formKey = GlobalKey<FormState>();
  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredUserName = '';
  File? _selectedImg;
  bool isLogin = true;
  bool isAuthenticating = false;

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
    if (!isValid || (!isLogin && _selectedImg == null)) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      isAuthenticating = true;
    });
    try {
      if (isLogin) {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final signUpUser = await _firebaseAuth.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('userProfileImage')
            .child('${signUpUser.user!.uid}.jpg');
        await storageRef.putFile(_selectedImg!);
        final imgUrl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(signUpUser.user!.uid)
            .set(
          {
            'userName': _enteredUserName,
            'profileImg': imgUrl,
            'email': _enteredEmail,
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      showSnackAlert(e.message ?? 'Authentication Error');
      setState(() {
        isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: Text(
          isLogin ? 'Welcome' : 'Create an account',
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLogin)
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 150,
                  child: Image.asset('assets/image/chat.png'),
                ),
              Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isLogin)
                          UserImagePicker(
                            onPickImage: (pickedImg) {
                              _selectedImg = pickedImg;
                            },
                          ),
                        if (!isLogin)
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'User name'),
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
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                          ),
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          enableSuggestions: true,
                          textCapitalization: TextCapitalization.none,
                          validator: (val) {
                            return _emailValidator(val);
                          },
                          onSaved: (val) {
                            _enteredEmail = val!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: (val) {
                            return _passwordValidator(val);
                          },
                          onSaved: (val) {
                            _enteredPassword = val!;
                          },
                        ),
                        const SizedBox(height: 18),
                        if (isAuthenticating)
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
                                Text(
                                  isLogin
                                      ? 'Authenticating ..'
                                      : 'Saving data ..',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
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
                        if (!isAuthenticating)
                          ElevatedButton(
                            onPressed: handelSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.background,
                            ),
                            child: Text(
                              isLogin ? 'Sign In' : 'Sign Up',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        if (!isAuthenticating)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _formKey.currentState!.reset();
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              isLogin
                                  ? 'Create an account'
                                  : 'I already have an account',
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String? _passwordValidator(String? val) {
  if (val == null || val.trim().isEmpty) {
    return 'Required *';
  }
  if (!val.contains('@') &&
      !val.contains('!') &&
      !val.contains('#') &&
      !val.contains('\$') &&
      !val.contains('%') &&
      !val.contains('^') &&
      !val.contains('&') &&
      !val.contains('*')) {
    return 'Password must contains any one of !,@,#,\$,%,^,&,*';
  }
  if (!val.contains('0') &&
      !val.contains('1') &&
      !val.contains('2') &&
      !val.contains('3') &&
      !val.contains('4') &&
      !val.contains('5') &&
      !val.contains('6') &&
      !val.contains('7') &&
      !val.contains('8') &&
      !val.contains('9')) {
    return 'Password must contains a digit.';
  }
  if (val.trim().length < 6) {
    return 'Password must be at least 6 characters long. ';
  }
  return null;
}

String? _emailValidator(String? val) {
  if (val == null || val.trim().isEmpty) {
    return 'Required *';
  }
  if (!val.contains('@')) {
    return 'Please enter a valid email address.';
  }
  return null;
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
