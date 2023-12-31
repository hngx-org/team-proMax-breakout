import 'package:bluck_buster/features/game/game_page.dart';
import 'package:flutter/material.dart';

import 'features/splash/next.splash.view.dart';
import 'features/splash/splash.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: const SplashView(),
      routes: {
        '/nextSplash': (context) => const NextSplash(),
        // '/menuScreen': (context) => const GameMenu(),
        '/gameScreen': (context) => const GamePage(),
      },
    );
  }
}
