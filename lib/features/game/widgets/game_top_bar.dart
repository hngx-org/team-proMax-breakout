import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_score.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class GameTopBar extends StatelessWidget {
  const GameTopBar({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      color: Colors.white.withOpacity(0.2),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.025, vertical: height * 0.035),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Image.asset(
              'assets/images/home.png',
              height: 45,
              width: 45,
              fit: BoxFit.cover,
            ),
            onTap: () {
              (game as BricksBreaker).togglePauseState();
              AudioPlayer().play(
                AssetSource('audio/btnPressed.mp3'),
              );
            },
          ),
          SizedBox(
            width: width * 0.011,
          ),
          GameScore(
            game: game,
          ),
          SizedBox(
            width: width * 0.025,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10),
            child: ValueListenableBuilder<int>(
                valueListenable: (game as BricksBreaker).gameManager.life,
                builder: (context, val, c) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        val,
                        (index) => Padding(
                              padding: const EdgeInsets.all(3),
                              child: Image.asset("assets/images/live.png"),
                            )),
                  );
                }),
          ),
          GestureDetector(
            child: const Icon(
              Icons.bolt,
              size: 35,
              color: Colors.white,
            ),
            onTap: () {
              AudioPlayer().play(
                AssetSource('audio/speedUp.mp3'),
              );
              (game as BricksBreaker).increaseBallSpeed();
            },
          ),
          GestureDetector(
            child: Image.asset(
              'assets/images/pause.png',
              height: 45,
              width: 45,
              fit: BoxFit.cover,
            ),
            onTap: () {
              (game as BricksBreaker).togglePauseState();
              AudioPlayer().play(
                AssetSource('audio/btnPressed.mp3'),
              );
            },
          ),
        ],
      ),
    );
  }
}
