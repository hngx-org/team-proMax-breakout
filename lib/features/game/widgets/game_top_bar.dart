import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_score.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameTopBar extends StatelessWidget {
  const GameTopBar({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 25, 14, 8),
        child: Wrap(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
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
            const SizedBox(
              width: 10,
            ),
            GameScore(
              game: game,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder<int>(
                    valueListenable: (game as BricksBreaker).gameManager.life,
                    builder: (context, val, c) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            val,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Image.asset("assets/images/live.png"),
                                )),
                      );
                    }),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.bolt,
                size: 32,
                color: Colors.white,
              ),
              onPressed: () {
                (game as BricksBreaker).increaseBallSpeed();
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/pause.png',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
              onPressed: () {
                (game as BricksBreaker).togglePauseState();
              },
            ),
          ],
        ),
      ),
    );
  }
}
