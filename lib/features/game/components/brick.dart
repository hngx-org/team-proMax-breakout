import 'dart:math';
import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/components/ball.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flutter/material.dart';

class Brick extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BricksBreaker> {
  Brick({
    required this.brickRow,
    required this.brickColumn,
    required double size,
  }) : super(
          size: Vector2.all(size),
        );

  int brickRow;
  int brickColumn;
  bool hasCollided = false;

  // late final TextComponent brickText;
  late final RectangleHitbox rectangleBrickHitBox;
  late final RectangleComponent rectangleBrick;

  @override
  Future<void> onLoad() async {
    await _loadImages();

    // if (false) {
    //   removeFromParent();
    //   return;
    // }
    //
    // brickText = createBrickTextComponent();
    // rectangleBrick = createBrickRectangleComponent();
    rectangleBrickHitBox = createBrickRectangleHitbox();

    addAll([
      // rectangleBrick,
      rectangleBrickHitBox,
      // brickText,
    ]);
  }

  @override
  void update(double dt) {
    if (hasCollided) {
      // brickText.text = '$brickValue';
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ball && !hasCollided) {
      hasCollided = true;
      handleCollision();
    }
    if (children.whereType<Brick>().length == 1) {
      gameRef.gameWon();
    }

    super.onCollision(intersectionPoints, other);
  }

  bool generateWithProbability(double percent) {
    final Random rand = Random();

    var randomInt = rand.nextInt(100) + 1; // generate a number 1-100 inclusive

    if (randomInt <= percent) {
      return true;
    }

    return false;
  }

  RectangleHitbox createBrickRectangleHitbox() {
    return RectangleHitbox(
      size: size,
    );
  }

  RectangleComponent createBrickRectangleComponent() {
    return RectangleComponent(
      size: size,
      paint: Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(brickColor),
    );
  }

  void handleCollision() {
    gameRef.gameManager.increaseScore();
    FlameAudio.play(ballAudio);
    removeFromParent();

    if (gameRef.children.whereType<Brick>().length == 1) {
      gameRef.gameWon();
    } else if (gameRef.children.whereType<Brick>().length == 2) {
      if (gameRef.children
          .whereType<Brick>()
          .every((element) => element.hasCollided)) {
        gameRef.gameWon();
      }
    }

    return;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (hasCollided) {
      hasCollided = false;
    }
    super.onCollisionEnd(other);
  }

  Future<void> _loadImages() async {
    var r = Random();
    final images = [
      'blue_brick.png',
      'red_brick.png',
      'grey_brick.png',
    ];
    // var image = Flame.images.loadAll(['blue_brick.png']);
    var randomIndex = r.nextInt(images.length);
    sprite = await Sprite.load(images[randomIndex]);
  }
}
