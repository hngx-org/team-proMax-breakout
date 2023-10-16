import 'package:bluck_buster/authentication/signup.dart';
import 'package:bluck_buster/features/game/game_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'authentication/Signi.dart';
import 'authentication/verify_email.dart';
import 'core/utils/routes.dart';
import 'features/menu/menu.view.dart';
import 'features/splash/next.splash.view.dart';
import 'features/splash/splash.view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  runApp(
    const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const SplashView(),
      routes: {
        '/nextSplash': (context) => const NextSplash(),
        '/menuScreen': (context) => const GameMenu(),
        '/gameScreen': (context) => const GamePage(),
        loginRoute: (context) => LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    );
  }
}
