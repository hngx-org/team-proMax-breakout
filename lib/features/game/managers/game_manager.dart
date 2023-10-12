
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameManager extends Component with HasGameRef<BricksBreaker> {
  GameManager();

  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<int> life = ValueNotifier(3);

  GameState state = GameState.intro;

  void reset() {
    score.value = 0;
    life.value = 3;
  }

  void increaseScore() {
    score.value++;
  }

  void reduceLive() {
    life.value -=1;
  }

  void increaseLife() {
    life.value++;
  }
}

enum GameState { intro, playing, gameOver }
