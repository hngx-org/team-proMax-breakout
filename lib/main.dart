import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import '/features/auth/app.auth.dart';
import '/features/game/level_screen.dart';
import 'features/menu/menu.view.dart';
import 'features/splash/next.splash.view.dart';
import 'features/splash/splash.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
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
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashView();
            }
            if (snapshot.hasData) {
              return const GameMenu();
            }
            return const AuthScreen();
          }),
      routes: {
        '/nextSplash': (context) => const NextSplash(),
        '/menuScreen': (context) => const GameMenu(),
        '/levelScreen': (context) => const LevelScreen(),
        '/authScreen': (context) => const AuthScreen(),
        // '/gameScreen': (context) =>  GamePage(),
      },
    );
  }
}
