import 'package:bluck_buster/components/shared/app_colors.dart';
import 'package:bluck_buster/components/widgets/app.button.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GameMenu extends StatefulWidget {
  const GameMenu({super.key});

  @override
  State<GameMenu> createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> {
  @override
  void initState() {
    AudioPlayer().play(
      AssetSource('audio/gameBckgrnd.mp3'),
    );
    super.initState();
  }

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
        child: Stack(
          children: [
            Positioned(
              right: width * 0.06,
              top: height * 0.07,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AppDIALOG(
                          reason: 'Coming Soon',
                          btnTxt: 'Continue',
                          onTap: () => Navigator.pop(context),
                        ),
                      );
                    },
                    child: Image.asset(
                      infoBtn,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AppDIALOG(
                          reason: 'Coming Soon',
                          btnTxt: 'Continue',
                          onTap: () => Navigator.pop(context),
                        ),
                      );
                    },
                    child: Image.asset(
                      shopBtn,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AppDIALOG(
                          reason: 'Coming Soon',
                          btnTxt: 'Continue',
                          onTap: () => Navigator.pop(context),
                        ),
                      );
                    },
                    child: Image.asset(
                      shareBtn,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Lottie.asset(
                menuAn,
              ),
            ),
            Positioned(
              top: height * 0.8,
              left: width * 0.4,
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, '/gameScreen'),
                child: Image.asset(
                  playBtn,
                ),
              ),
            ),
            Positioned(
              top: height * 0.86,
              left: width * 0.17,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AppDIALOG(
                      reason: 'Coming Soon',
                      btnTxt: 'Continue',
                      onTap: () => Navigator.pop(context),
                    ),
                  );
                },
                child: Image.asset(
                  settingsBtn,
                ),
              ),
            ),
            Positioned(
              top: height * 0.86,
              left: width * 0.65,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AppDIALOG(
                      reason: 'Coming Soon',
                      btnTxt: 'Continue',
                      onTap: () => Navigator.pop(context),
                    ),
                  );
                },
                child: Image.asset(
                  menuBtn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
