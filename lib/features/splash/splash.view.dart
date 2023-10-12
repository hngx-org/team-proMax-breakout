import 'package:bluck_buster/components/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

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
      const Duration(seconds: 4),
    ).then(
      (value) => Navigator.pushReplacementNamed(
        context,
        '/nextSplash',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RiveAnimation.asset(
          teamProMax,
        ),
      ),
    );
  }
}
