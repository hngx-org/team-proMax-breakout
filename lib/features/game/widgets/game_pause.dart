import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_score.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GamePause extends StatelessWidget {
  const GamePause({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
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
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              GameScore(
                game: game,
              ),
              const SizedBox(height: 20),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/play.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                      onPressed: () {
                        (game as BricksBreaker).togglePauseState();
                      },
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/images/reload.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                      onPressed: () {
                        (game as BricksBreaker).resetGame();
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/images/home.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                onPressed: () {
                  (game as BricksBreaker).togglePauseState();
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
