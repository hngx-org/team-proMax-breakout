import 'package:bluck_buster/components/widgets/app.button.dart';
import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_score.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bluck_buster/features/game/widgets/game_over.dart' show GameTimer;





class GameTimer {
  late Timer _timer;
  late Duration _duration;
  late Function(Duration) _onTick;
  bool _isActive = false;

  GameTimer({
    Duration? duration,
    Function(Duration)? onTick,
  }) {
    _duration = duration ?? Duration(seconds: 1);
    _onTick = onTick ?? (Duration duration) {};
  }

  bool get isActive => _isActive;

  void start() {
    if (!_isActive) {
      _timer = Timer.periodic(_duration, _tick);
      _isActive = true;
    }
  }

  void pause() {
    if (_isActive) {
      _timer.cancel();
      _isActive = false;
    }
  }

  void resume() {
    if (!_isActive) {
      _timer = Timer.periodic(_duration, _tick);
      _isActive = true;
    }
  }

  void stop() {
    if (_isActive) {
      _timer.cancel();
      _isActive = false;
    }
  }

  void _tick(Timer timer) {
    _onTick(_duration * (timer.tick - 1));
  }
}




class GameOver extends StatelessWidget {
  const GameOver({
    super.key,
    required this.game,
    required this.gameTimer,
  });

  final Game game;
  final GameTimer gameTimer;




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
                      gameTimer.start();
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
