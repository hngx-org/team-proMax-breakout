// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bluck_buster/components/shared/app_colors.dart';
import 'package:bluck_buster/components/widgets/app.button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // var authModel = AuthViewModel();
  final formKey = GlobalKey<FormState>();
  final fBase = FirebaseAuth.instance;
  final fDB = FirebaseFirestore.instance;

  //
  bool isLoggedIn = true;
  bool hide = true;
  final userMsg = 'username should be 4 characters minimum';
  final emailMsg = 'please enter a valid email address';
  final pswdMsg = 'password should be 6 characters minimum';

  var userName = '';
  var userEmail = '';
  var userPswd = '';

  void submit() async {
    formKey.currentState!.validate();

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
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                menuBckgrnd,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isLoggedIn ? 'Login' : 'Create Account',
                          style: const TextStyle(
                            fontFamily: 'Khand',
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: height * .02),
                        if (!isLoggedIn)
                          TextFormField(
                            style: const TextStyle(
                              fontFamily: 'Khand',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                fontFamily: 'Khand',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.length < 4) {
                                return userMsg;
                              }
                              return null;
                            },
                          ),
                        SizedBox(height: height * .02),
                        TextFormField(
                          style: const TextStyle(
                            fontFamily: 'Khand',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          decoration: const InputDecoration(
                            labelText: 'Email address',
                            labelStyle: TextStyle(
                              fontFamily: 'Khand',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return emailMsg;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * .02),
                        TextFormField(
                          style: const TextStyle(
                            fontFamily: 'Khand',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textCapitalization: TextCapitalization.none,
                          obscureText: hide,
                          obscuringCharacter: '•',
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              fontFamily: 'Khand',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hide = !hide;
                                });
                              },
                              icon: Icon(
                                hide
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return pswdMsg;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * .03),
                        AppBTN(
                          title: isLoggedIn ? 'Login' : 'Sign Up',
                          onTap: submit,
                        ),
                        SizedBox(height: height * .03),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isLoggedIn = !isLoggedIn;
                            });
                          },
                          child: Text(
                            isLoggedIn
                                ? 'Click to create account'
                                : 'Already have account',
                            style: const TextStyle(
                              fontFamily: 'Khand',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kcPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
