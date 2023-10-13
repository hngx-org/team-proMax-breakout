import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_score.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class GamePause extends StatelessWidget {
  const GamePause({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Material(
      color: const Color(panelColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'GAME PAUSED',
                  style: TextStyle(
                      fontFamily: 'Khand',
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: height * 0.02),
              GameScore(
                game: game,
              ),
              SizedBox(height: height * 0.02),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/play.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      onPressed: () {
                        (game as BricksBreaker).togglePauseState();
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
                        (game as BricksBreaker).resetGame();
                        AudioPlayer().play(
                          AssetSource('audio/press.mp3'),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              IconButton(
                icon: Image.asset(
                  'assets/images/home.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                onPressed: () {
                  (game as BricksBreaker).togglePauseState();
                  AudioPlayer().play(
                    AssetSource('audio/press.mp3'),
                  );
                },
              ),
              // GameButton(
              //   onPressed: () {
              //     (game as BricksBreaker).togglePauseState();
              //   },
              //   title: 'CONTINUE',
              //   color: continueButtonColor,
              //   width: 200,
              // ),
              // const SizedBox(height: 20),
              // GameButton(
              //   onPressed: () {
              //     (game as BricksBreaker).resetGame();
              //   },
              //   title: 'RESTART',
              //   color: restartButtonColor,
              //   width: 200,
              // ),
              // const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
