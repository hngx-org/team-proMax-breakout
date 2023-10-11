import '/components/shared/app_colors.dart';
import 'package:flutter/material.dart';

class NextSplash extends StatefulWidget {
  const NextSplash({super.key});

  @override
  State<NextSplash> createState() => _NextSplashState();
}

class _NextSplashState extends State<NextSplash> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            splashBckgrnd,
            width: width,
            height: height,
          ),
          Center(
            child: Image.asset(
              splashSecond,
            ),
          ),
        ],
      ),
    );
  }
}
