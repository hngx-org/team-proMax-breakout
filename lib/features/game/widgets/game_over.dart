import 'package:bluck_buster/components/widgets/app.button.dart';
import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_score.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({
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
                Center(
                  child: Image.asset(
                    'assets/images/game_over.png',
                    width: 400,
                    fit: BoxFit.contain,
                  ),
                ),
                GameScore(
                  game: game,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: AppBTN(
                    title: 'TRY AGAIN',
                    onTap: () {
                      (game as BricksBreaker).resetGame();
                    },
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     (game as BricksBreaker).resetGame();
                //   },
                //   style: TextButton.styleFrom(
                //     foregroundColor: Colors.black,
                //     backgroundColor: Colors.white,
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 30, vertical: 16),
                //     shape: const StadiumBorder(),
                //   ),
                //   // title: 'TRY AGAIN',
                //   // color: Colors.white,
                //   // fgColor: Colors.black,
                //   // width: 200,
                //   child: const Text(
                //     "TRY AGAIN",
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
