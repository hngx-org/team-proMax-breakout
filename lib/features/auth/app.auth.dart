import 'package:bluck_buster/components/shared/app_colors.dart';
import 'package:bluck_buster/components/widgets/app.button.dart';
import 'package:bluck_buster/features/auth/auth.model.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var authModel = AuthViewModel();

  var userName = '';
  var userEmail = '';
  var userPswd = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
          key: authModel.formKey,
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
                        authModel.isLoggedIn ? 'Login' : 'Create Account',
                        style: const TextStyle(
                          fontFamily: 'Khand',
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: height * .02),
                      if (!authModel.isLoggedIn)
                        TextFormField(
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
                              return authModel.userMsg;
                            }
                            return null;
                          },
                          onSaved: authModel.userSaved(userName),
                        ),
                      SizedBox(height: height * .02),
                      TextFormField(
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
                            return authModel.emailMsg;
                          }
                          return null;
                        },
                        onSaved: authModel.emailSaved(userEmail),
                      ),
                      SizedBox(height: height * .02),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textCapitalization: TextCapitalization.none,
                        obscureText: authModel.hide,
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
                                authModel.hide = !authModel.hide;
                              });
                            },
                            icon: Icon(
                              authModel.hide
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return authModel.pswdMsg;
                          }
                          return null;
                        },
                        onSaved: authModel.pswdSaved(userPswd),
                      ),
                      SizedBox(height: height * .03),
                      AppBTN(
                        title: authModel.isLoggedIn ? 'Login' : 'Sign Up',
                        onTap: authModel.submit(context),
                      ),
                      SizedBox(height: height * .03),
                      InkWell(
                        onTap: () {
                          setState(() {
                            authModel.isLoggedIn = !authModel.isLoggedIn;
                          });
                        },
                        child: Text(
                          authModel.isLoggedIn
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
    );
  }
}
