import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/components/shared/app_colors.dart';

class NextSplash extends StatefulWidget {
  const NextSplash({super.key});

  @override
  State<NextSplash> createState() => _NextSplashState();
}

class _NextSplashState extends State<NextSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
    ).then(
      (value) => Navigator.pushReplacementNamed(context, '/menuScreen'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              splashBckgrnd,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Image.asset(
                splashSecond,
              ),
            ),
            Positioned(
              top: height * 0.93,
              left: width * 0.2,
              child: Center(
                child: Lottie.asset(
                  loading,
                  height: height * 0.03,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
