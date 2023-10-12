import 'dart:ui';

import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';

class Paddle extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BricksBreaker> {
  Paddle(Image image)
      : super.fromImage(
          image,
          size: Vector2(50, 10),
        );

  bool hasCollided = false;

  late final RectangleHitbox rectangleBrickHitBox;
  late final RectangleComponent rectangleBrick;

  @override
  Future<void> onLoad() async {
    position = Vector2(
      (gameRef.board.size.x / 2) - 20,
      (gameRef.board.size.y - 20),
    );
    rectangleBrick = createBrickRectangleComponent();
    rectangleBrickHitBox = createBrickRectangleHitbox();

    addAll([
      // rectangleBrick,
      rectangleBrickHitBox,
      // brickText,
    ]);
  }

  @override
  void update(double dt) {
    if (hasCollided) {}
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // if (other is Ball && !hasCollided) {
    //   hasCollided = true;
    //   handleCollision();
    // }
    super.onCollision(intersectionPoints, other);
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
    FlameAudio.play(ballAudio);
  }

  void dragPaddle(double xPosition) {
    position.x = xPosition;
  }

  void resetPosition() {
    position = Vector2(
      (gameRef.board.size.x / 2) - 20,
      (gameRef.board.size.y - 20),
    );
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (hasCollided) {
      hasCollided = false;
    }
    super.onCollisionEnd(other);
  }
}
