import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_over.dart';
import 'package:bluck_buster/features/game/widgets/game_pause.dart';
import 'package:bluck_buster/features/game/widgets/game_top_bar.dart';
import 'package:bluck_buster/features/game/widgets/game_won.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:bluck_buster/features/game/widgets/game_top_bar.dart' show GameTimer;
import 'package:bluck_buster/features/game/widgets/game_over.dart' show GameTimer;
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

class GamePage extends StatefulWidget {

  const GamePage({
    super.key,
    required this.initialLevel,
  });

  final int initialLevel;

  @override
  State<GamePage> createState() => _GamePageState();
}

  Game? game;



class _GamePageState extends State<GamePage> {
  late GameTimer gameTimer;

  // @override
  // void initState() {
  //   super.initState();
  //   gameTimer = GameTimer(
  //       duration: const Duration(seconds: 1),
  //       onTick: (Duration duration) {
  //         setState(() {
  //           // Update your game timer logic here
  //         });
  //       });
  //   game = BricksBreaker(widget.initialLevel, gameTimer);
  // }


  @override
  void initState() {
    super.initState();
    gameTimer = GameTimer(
      duration: const Duration(seconds: 1),
      onTick: (Duration duration) {
        setState(() {
          // Update your game timer logic here
        });
      },
    );
    gameTimer.start();
    game = BricksBreaker(widget.initialLevel, gameTimer);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x5bffffff),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/game-bg.png',
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              GameTopBar(
                game: game!,
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: GameWidget(
                    game: game!,
                    overlayBuilderMap: <String,
                        Widget Function(BuildContext, Game)>{
                      'gameOverOverlay': (context, game) => GameOver(
                            game: game,
                            gameTimer: gameTimer,
                          ),
                      'gamePauseOverlay': (context, game) => GamePause(
                            game: game,

                          ),
                      'gameWonOverlay': (context, game) => GameWon(
                            game: game,
                          ),
                    },
                  ),
                ),
              ),
              Container(color: Colors.white.withOpacity(0.2), height: 70)
            ],
          ),
        ],
      ),
    );
  }
}
