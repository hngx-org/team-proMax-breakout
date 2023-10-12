import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/widgets/game_over.dart';
import 'package:bluck_buster/features/game/widgets/game_pause.dart';
import 'package:bluck_buster/features/game/widgets/game_top_bar.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.title});

  final String title;

  @override
  State<GamePage> createState() => _GamePageState();
}

final Game game = BricksBreaker()..backgroundColor();

class _GamePageState extends State<GamePage> {
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
                game: game,
              ),
              Expanded(
                child: GameWidget(
                  game: game,
                  overlayBuilderMap: <String,
                      Widget Function(BuildContext, Game)>{
                    'gameOverOverlay': (context, game) => GameOver(
                          game: game,
                        ),
                    'gamePauseOverlay': (context, game) => GamePause(
                          game: game,
                        ),
                  },
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ],
      ),
    );
  }
}
