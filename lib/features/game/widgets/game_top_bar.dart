import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_score.dart';
import 'package:bluck_buster/features/menu/menu.view.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'dart:async';





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

class GameTopBar extends StatefulWidget {
  const GameTopBar({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  State<GameTopBar> createState() => _GameTopBarState();
}

class _GameTopBarState extends State<GameTopBar> {



  late GameTimer gameTimer;
  Duration initialDuration = Duration(minutes: 1);
  late Duration remainingDuration;

  @override
  void initState() {
    super.initState();
    remainingDuration = initialDuration;
    gameTimer = GameTimer(
      duration: const Duration(seconds: 1),
      onTick: (Duration duration) {
        setState(() {
          remainingDuration = initialDuration - duration;
          if (remainingDuration == Duration.zero) {
            (widget.game as BricksBreaker).gameOver();
            gameTimer.stop();
          }
        });
      },
    );
    gameTimer.start();
  }

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
          // GestureDetector(
          //   child: Image.asset(
          //     'assets/images/home.png',
          //     height: 45,
          //     width: 45,
          //     fit: BoxFit.cover,
          //   ),
          //   onTap: () {
          //     Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const GameMenu(),
          //         ));
          //     AudioPlayer().play(
          //       AssetSource('audio/btnPressed.mp3'),
          //     );
          //   },
          // ),
          Text(
            ' ${remainingDuration.inMinutes}:${remainingDuration.inSeconds % 60}',
            style: TextStyle(fontSize: 30,fontFamily: 'khand'),
          ),
          SizedBox(
            width: width * 0.011,
          ),
          GameScore(
            game: widget.game,
          ),
          SizedBox(
            width: width * 0.025,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10),
            child: ValueListenableBuilder<int>(
                valueListenable: (widget.game as BricksBreaker).gameManager.life,
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
              (widget.game as BricksBreaker).increaseBallSpeed();
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
              (widget.game as BricksBreaker).togglePauseState();
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
