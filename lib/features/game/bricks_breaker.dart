import 'dart:math';

import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/components/ball.dart';
import 'package:bluck_buster/features/game/components/board.dart';
import 'package:bluck_buster/features/game/components/brick.dart';
import 'package:bluck_buster/features/game/components/paddle.dart';
import 'package:bluck_buster/features/game/managers/game_manager.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BricksBreaker extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  BricksBreaker(this.initialLevel, {super.children});

  final int initialLevel;

  final GameManager gameManager = GameManager();
  late final Ball ball;
  final Board board = Board();
  late final Paddle paddle;

  // int numberOfBricksLayer = 5;
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final image = await Flame.images.load('paddle.png');
    final ballImage = await Flame.images.load('ball.png');
    ball = Ball(ballImage);
    paddle = Paddle(image);
    await addAll([board, ball, paddle]);
    await add(gameManager);
    gameManager.setCurrentLevel(initialLevel);
    ball.ballState = BallState.idle;
    ball.priority = 1;
    loadInitialBrickLayer();
    resetPositions();

    // overlays.add('gameStartOverlay');
  }

  @override
  Color backgroundColor() {
    return Colors.white.withOpacity(0.2);
  }

  void resetGame() {
    pauseEngine();
    overlays.remove('gamePauseOverlay');
    overlays.remove('gameOverOverlay');
    overlays.remove('gameWonOverlay');
    children.whereType<Brick>().forEach((brick) {
      brick.removeFromParent();
    });
    gameManager.reset();
    ball.resetBall();
    board.resetBoard();
    paddle.resetPosition();
    resumeEngine();
    // numberOfBricksLayer = 2;
    loadInitialBrickLayer();
    // overlays.add('gameStartOverlay');
  }

  void goToNextLevel() {
    pauseEngine();
    overlays.remove('gamePauseOverlay');
    overlays.remove('gameOverOverlay');
    overlays.remove('gameWonOverlay');
    children.whereType<Brick>().forEach((brick) {
      brick.removeFromParent();
    });
    gameManager.goToNextLevel();
    ball.resetBall();
    board.resetBoard();
    paddle.resetPosition();
    resumeEngine();
    // numberOfBricksLayer = 2;
    loadInitialBrickLayer();
    // overlays.add('gameStartOverlay');
  }

  void previousLevel() {
    pauseEngine();
    overlays.remove('gamePauseOverlay');
    overlays.remove('gameOverOverlay');
    overlays.remove('gameWonOverlay');
    children.whereType<Brick>().forEach((brick) {
      brick.removeFromParent();
    });
    gameManager.goToPreviousLevel();
    ball.resetBall();
    board.resetBoard();
    paddle.resetPosition();
    resumeEngine();
    // numberOfBricksLayer = 2;
    loadInitialBrickLayer();
    // overlays.add('gameStartOverlay');
  }

  void togglePauseState() {
    if (paused) {
      overlays.remove('gamePauseOverlay');
      resumeEngine();
    } else {
      overlays.add('gamePauseOverlay');
      pauseEngine();
    }
  }

  void startGame() {
    overlays.remove('gameStartOverlay');
    ball.xDirection = 0;
    ball.yDirection = -1;
    final newPosition = Vector2(4, board.y - 3);
    ball.nextPosition.setFrom(newPosition);
    ball.ballState = BallState.release;
    priority = 0;
  }

  void resetPositions() {
    ball.resetBall();
    paddle.resetPosition();
  }

  double get brickSize {
    const totalPadding = (numberOfBricksInRow + 1) * brickPadding;
    final screenMinSize = size.x < size.y ? size.x : size.y;
    return (screenMinSize - totalPadding) / numberOfBricksInRow;
  }

  int next(int min, int max) => min + _random.nextInt(max);

  List<Brick> generateBrickLayer(int row) {
    return List<Brick>.generate(
      numberOfBricksInRow,
      (index) => Brick(
        // brickValue: next(minValueOfBrick, maxValueOfBrick),
        size: brickSize,
        brickRow: row,
        brickColumn: index,
      ),
    );
  }

  Future<void> loadInitialBrickLayer() async {
    for (var row = 0; row < gameManager.numberOfLayers; row++) {
      final bricksLayer = generateBrickLayer(row);
      for (var i = 0; i < numberOfBricksInRow; i++) {
        final xPosition = i == 0
            ? 8
            : bricksLayer[i - 1].position.x + bricksLayer[i - 1].size.x + 8;
        final yPosition = (row + 1) * (brickSize + 8);

        await add(
          bricksLayer[i]..position = Vector2(xPosition.toDouble(), yPosition),
        );
      }
    }
  }

  Future<void> removeBrickLayerRow(int row) async {
    final bricksToRemove = children
        .whereType<Brick>()
        .toList()
        .where((element) => element.brickRow == row);

    for (final brick in bricksToRemove) {
      brick.removeFromParent();
    }
  }

  Future<void> removeBrickLayerColumn(int column) async {
    final bricksToRemove = children
        .whereType<Brick>()
        .toList()
        .where((element) => element.brickColumn == column);

    for (final brick in bricksToRemove) {
      brick.removeFromParent();
    }
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
  }

  Future<void> updateBrickPositions() async {
    final brickComponents = children.whereType<Brick>().toList();

    for (final brick in brickComponents) {
      final nextYPosition = brick.position.y + brickSize + 8;
      if (board.size.y - ball.size.y <= nextYPosition + brick.size.y) {
        pauseEngine();

        gameManager.state = GameState.gameOver;
        ball.ballState = BallState.idle;

        overlays.add('gameOverOverlay');

        return;
      }
      brick.position.y = nextYPosition;
    }

    final bricksLayer = generateBrickLayer(gameManager.numberOfLayers);
    for (var i = 0; i < 7; i++) {
      await add(
        bricksLayer[i]
          ..position = Vector2(
            i == 0
                ? 8
                : bricksLayer[i - 1].position.x + bricksLayer[i - 1].size.x + 8,
            brickSize + 8,
          ),
      );
    }
    // gameManager.numberOfLayers++;
    ball.ballState = BallState.idle;
    gameManager.increaseScore();
  }

  void increaseBallSpeed() {
    ball.increaseSpeed();
  }

  void gameOver() {
    pauseEngine();

    gameManager.state = GameState.gameOver;
    ball.ballState = BallState.idle;

    overlays.add('gameOverOverlay');
  }

  void gameWon() {
    pauseEngine();
    // gameManager.state = GameState.intro;
    ball.ballState = BallState.idle;
    overlays.add('gameWonOverlay');
  }
}
