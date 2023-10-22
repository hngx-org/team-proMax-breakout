// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel {
  final formKey = GlobalKey<FormState>();
  final fBase = FirebaseAuth.instance;
  final fDB = FirebaseFirestore.instance;

  //
  bool isLoggedIn = true;
  final userMsg = 'username should be 4 characters minimum';
  final emailMsg = 'please enter a valid email address';
  final pswdMsg = 'password should be 6 characters minimum';
  bool hide = true;
  bool isLoading = false;

  var userName = '';
  var userEmail = '';
  var userPswd = '';
  //
  pswdSaved(String? value) {
    userPswd = value!;
  }

  emailSaved(String? value) {
    userEmail = value!;
  }

  userSaved(String? value) {
    userName = value!;
  }

  submit(BuildContext context) async {
    final isValid = formKey.currentState!.validate();

    try {
      if (isLoggedIn) {
        final userCred = await fBase.signInWithEmailAndPassword(
          email: userEmail,
          password: userPswd,
        );
        debugPrint('$userCred'); //for testing credentials
      } else {
        final userCred = await fBase.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPswd,
        );

        await fDB.collection('users').doc(userCred.user!.uid).set({
          'username': userName,
          'email': userEmail,
        });
        debugPrint('$userCred'); //for testing credentials
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        //.. some codeblock
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'Authentication failed',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Khand',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

      //check user values
      if (isValid) {
        formKey.currentState!.save();
        debugPrint(!isLoggedIn ? userName : '');
        debugPrint(userEmail);
        debugPrint(userPswd);
      }
    }
  }
}
