import 'package:bluck_buster/components/shared/app_colors.dart';
import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_score.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GameWon extends StatefulWidget {
  const GameWon({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  State<GameWon> createState() => _GameWonState();
}

class _GameWonState extends State<GameWon> {
  @override
  void initState() {
    AudioPlayer().play(
      AssetSource('audio/clap.mp3'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Material(
      color: const Color(panelColor),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              wonGame,
              height: height * 0.32,
            ),
            SizedBox(height: height * 0.02),
            const Center(
              child: Text(
                'YOU WON',
                style: TextStyle(
                    fontFamily: 'Khand',
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: height * 0.02),
            GameScore(
              game: widget.game,
            ),
            SizedBox(height: height * 0.02),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/home.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    onPressed: () {
                      (widget.game as BricksBreaker).togglePauseState();
                      AudioPlayer().play(
                        AssetSource('audio/press.mp3'),
                      );
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/reload.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    onPressed: () {
                      (widget.game as BricksBreaker).resetGame();
                      AudioPlayer().play(
                        AssetSource('audio/press.mp3'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
