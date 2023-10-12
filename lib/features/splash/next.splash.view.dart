import 'package:google_fonts/google_fonts.dart';

import '/components/shared/app_colors.dart';
import 'package:flutter/material.dart';

class NextSplash extends StatefulWidget {
  const NextSplash({super.key});

  @override
  State<NextSplash> createState() => _NextSplashState();
}

double loading = 0;

class _NextSplashState extends State<NextSplash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        loading = MediaQuery.of(context).size.width * 0.4;
      });
    });
    super.initState();
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
              left: width * 0.27,
              child: Container(
                width: width * 0.5,
                height: height * 0.03,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AnimatedContainer(
                  duration: const Duration(
                    seconds: 15,
                  ),
                  width: loading,
                  curve: Curves.easeIn,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: kcGoldColor,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        kcAccentColor,
                        kcPrimaryColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Loading....',
                      style: GoogleFonts.khand(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
