import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '/components/shared/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
    ).then(
      (value) => Navigator.pushReplacementNamed(
        context,
        '/nextSplash',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          teamProMax,
          height: MediaQuery.of(context).size.height * 0.2,
        ),
      ),
    );
  }
}
