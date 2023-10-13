import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_score.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameWon extends StatelessWidget {
  const GameWon({
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
          child: Builder(builder: (
              context,
              ) {
            // Future(() {
            //   ref.watch(gameSessionsControllerProvider.notifier).addGameSession(
            //         score: (game as BricksBreaker).gameManager.score.value,
            //       );
            // });

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'YOU WON',
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
                          'assets/images/home.png',
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
              ],
            );
          }),
        ),
      ),
    );
  }
}
