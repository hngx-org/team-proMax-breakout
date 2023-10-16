import 'dart:math';
import 'dart:ui';
import 'dart:developer' as log;
import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:bluck_buster/features/game/components/board.dart';
import 'package:bluck_buster/features/game/components/brick.dart';
import 'package:bluck_buster/features/game/components/paddle.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart' as f;
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class Ball extends SpriteComponent
    with HasGameRef<BricksBreaker>, CollisionCallbacks {
  Ball(f.Image image)
      : super.fromImage(
          image,
          paint: Paint()..color = const Color(ballColor),
          // radius: ballRadius,
          children: [CircleHitbox()],
        );

  BallState ballState = BallState.ideal;
  double speed = 3;
  static const degree = pi / 180;
  double xDirection = 0;
  double yDirection = 0;

  final nextPosition = Vector2.zero();

  double aimAngle = 0;
  Vector2 aimTriangleMidPoint = Vector2.zero();
  Vector2 aimTriangleBasePoint = Vector2.zero();
  List<Rect> aimPointerBalls = [];
  final aimPainter = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (position.y >= gameRef.board.size.y - size.y) {
      if (gameRef.gameManager.life.value <= 1) {
        gameRef.gameOver();
      } else {
        gameRef.gameManager.reduceLive();
      }

      FlameAudio.play('row_explosion.mp3');
      resetBall();
      gameRef.paddle.resetPosition();
      speed = 1;
    }

    if (ballState == BallState.release) {
      moveBall(dt);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (ballState == BallState.drag) {
      drawRotatedObject(
        canvas: canvas,
        center: Offset(size.x / 2, size.y / 2),
        angle: aimAngle,
        drawFunction: () => canvas.drawPath(aimPath, aimPainter),
      );
    } else if (ballState == BallState.ideal) {
      resetBall();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    ballState = BallState.ideal;

    super.onCollisionStart(intersectionPoints, other);

    if (other is Board) {
      reflectFromBoard(intersectionPoints);
      ballState = BallState.release;
      return;
    } else if (other is Brick) {
      reflectFromBrick(intersectionPoints, other);
      ballState = BallState.release;
      return;
    } else if (other is Paddle) {
      log.log("PADDLE COLLISION");
      reflectFromPaddle(intersectionPoints, other);
      ballState = BallState.release;
      return;
    }
  }

  void reflectFromBoard(Set<Vector2> intersectionPoints) {
    final isTopHit = intersectionPoints.first.y <= gameRef.board.position.y;
    final isLeftHit = intersectionPoints.first.x <= gameRef.board.position.x ||
        intersectionPoints.first.y <=
            gameRef.board.position.y + gameRef.board.size.y;
    final isRightHit = intersectionPoints.first.x >=
            gameRef.board.position.x + gameRef.board.size.x ||
        intersectionPoints.first.y <=
            gameRef.board.position.y + gameRef.board.size.y;

    if (isTopHit) {
      yDirection *= -1;
    } else if (isLeftHit || isRightHit) {
      xDirection *= -1;
    }
  }

  void reflectFromBrick(
      Set<Vector2> intersectionPoints, PositionComponent positionComponent) {
    if (intersectionPoints.length == 1) {
      sideReflection(intersectionPoints.first, positionComponent);
    } else {
      final intersectionPointsList = intersectionPoints.toList();
      final averageX = (intersectionPointsList[0].x + intersectionPointsList[1].x) / 2;
      final averageY = (intersectionPointsList[0].y + intersectionPointsList[1].y) / 2;
      if (intersectionPointsList[0].x == intersectionPointsList[1].x ||
          intersectionPointsList[0].y == intersectionPointsList[1].y) {
        sideReflection(Vector2(averageX, averageY), positionComponent);
      } else {
        cornerReflection(positionComponent, averageX, averageY);
      }
    }
  }

  void sideReflection(
      Vector2 intersectionPoints, PositionComponent positionComponent) {
    final isTopHit = intersectionPoints.y == positionComponent.position.y;
    final isBottomHit = intersectionPoints.y ==
        positionComponent.position.y + positionComponent.size.y;
    final isLeftHit = intersectionPoints.x == positionComponent.position.x;
    final isRightHit = intersectionPoints.x ==
        positionComponent.position.x + positionComponent.size.x;

    if (isTopHit || isBottomHit) {
      yDirection *= -1;
    } else if (isLeftHit || isRightHit) {
      xDirection *= -1;
    }
  }

  void cornerReflection(
    PositionComponent positionComponent,
    double averageX,
    double averageY,
  ) {
    final margin = size.x / 2;
    final xPosition = positionComponent.position.x;
    final yPosition = positionComponent.position.y;
    final leftHalf = xPosition - margin <= averageX && averageX < xPosition + margin;
    final topHalf = yPosition - margin <= averageY && averageY < yPosition + margin;

    xDirection = leftHalf ? -1 : 1;
    yDirection = topHalf ? -1 : 1;
  }

  void moveBall(double dt) {
    position
      ..x += xDirection * nextPosition.x * speed
      ..y += yDirection * nextPosition.y * speed;
  }

  void increaseSpeed() {
    if (speed < 2) {
      speed += 0.5;
    }
  }

  void resetBall() {
    position = Vector2(
      (gameRef.size.x / 2) - 10,
      (gameRef.size.y - 4 * 12) - 2,
    );
    speed = 1;
    ballState = BallState.ideal;
    aimTriangleMidPoint = Vector2(size.x / 2, -2 * size.y);
    aimTriangleBasePoint = Vector2(size.x / 4, -10 / 2);
    aimPointerBalls = List<Rect>.generate(
      16,
      (index) => Rect.fromCircle(
        center: Offset(
            aimTriangleMidPoint.x, aimTriangleMidPoint.y - (index + 1) * 20),
        radius: 3,
      ),
    );
  }

  void drawRotatedObject({
    required Canvas canvas,
    required Offset center,
    required double angle,
    required VoidCallback drawFunction,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);
    drawFunction();
    canvas.restore();
  }

  Path get aimPath {
    final path = Path()
      ..moveTo(aimTriangleMidPoint.x, aimTriangleMidPoint.y)
      ..lineTo(aimTriangleBasePoint.x, aimTriangleBasePoint.y)
      ..lineTo(3 * aimTriangleBasePoint.x, aimTriangleBasePoint.y);

    for (final ball in aimPointerBalls) {
      path.addOval(ball);
    }

    return path..close();
  }

  // double get getSpawnAngle {
  //   final sideToThrow = Random().nextBool();
  //   final random = Random().nextDouble();
  //   final spawnAngle = sideToThrow
  //       ? lerpDouble(-35, 35, random)!
  //       : lerpDouble(145, 215, random)!;
  //
  //   return spawnAngle;
  // }

  void reflectFromPaddle(
      Set<Vector2> intersectionPoints, PositionComponent positionComponent) {
    if (intersectionPoints.length == 1) {
      sideReflection(intersectionPoints.first, positionComponent);
    } else {
      final intersectionPointsList = intersectionPoints.toList();
      final averageX =
          (intersectionPointsList[0].x + intersectionPointsList[1].x) / 2;
      final averageY = (intersectionPointsList[0].y + intersectionPointsList[1].y) / 2;
      if (intersectionPointsList[0].x == intersectionPointsList[1].x || intersectionPointsList[0].y == intersectionPointsList[1].y) {
        sideReflection(Vector2(averageX, averageY), positionComponent);
      } else {
        cornerReflection(positionComponent, averageX, averageY);
      }
    }
  }
}
