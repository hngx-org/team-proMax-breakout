import 'dart:math';
import 'dart:developer' as d;
import 'package:bluck_buster/core/utils/constants.dart';
import 'package:bluck_buster/features/game/bricks_breaker.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Board extends RectangleComponent
    with DragCallbacks, HasGameRef<BricksBreaker> {
  Board()
      : super(
          paint: Paint()..color = const Color(0x00000000),
        );
  double dragLineSlope = 0;
  final dragStartPosition = Vector2.zero();
  final dragRelativePosition = Vector2.zero();
  final dividerPainter = Paint()
    ..color = const Color(0x00000000)
    ..style = PaintingStyle.fill;
  late final Path dividerPath;
  late final Vector2 centerPosition;

  @override
  Future<void> onLoad() async {
    size = Vector2(gameRef.size.x, gameRef.size.y);
    await add(RectangleHitbox());
    dividerPath = createDividerPath();
    centerPosition = position + (size / 2);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPath(dividerPath, dividerPainter);

    super.render(canvas);
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _handleDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (isBallInIdealOrDragState()) {
      _updateDragRelatedParameters(event);
      gameRef.ball.priority = 1;
    } else {
      _movePaddle(event);
    }
  }

  Path createDividerPath() {
    return Path()
      ..addRect(Rect.fromLTWH(0, -2, size.x, 2))
      ..addRect(Rect.fromLTWH(0, size.y, size.x, 2));
  }

  _handleDragStart(DragStartEvent event) {
    d.log("DRAG STARTED${gameRef.ball.ballState.name}");
    if (gameRef.ball.ballState == BallState.idle) {
      dragStartPosition.setFrom(event.localPosition.xx);
    }
  }

  bool isBallInIdealOrDragState() {
    return gameRef.ball.ballState == BallState.idle ||
        gameRef.ball.ballState == BallState.drag;
  }

  void _updateDragRelatedParameters(DragUpdateEvent event) {
    dragRelativePosition.setFrom(event.localPosition - dragStartPosition);

    final absolutePosition = (event.localPosition + dragStartPosition)
      ..absolute();
    final isValid = absolutePosition.x > 10 || absolutePosition.y > 10;

    if (!dragRelativePosition.y.isNegative && isValid) {
      gameRef.ball.ballState = BallState.drag;
      dragLineSlope = dragRelativePosition.y / dragRelativePosition.x;
      final sign =
          dragRelativePosition.x.sign == 0 ? 1 : dragRelativePosition.x.sign;
      gameRef.ball.aimAngle = atan(dragLineSlope) - sign * 90 * degrees2Radians;
    } else {
      gameRef.ball.ballState = BallState.idle;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (gameRef.ball.ballState == BallState.drag &&
        !dragRelativePosition.y.isNegative) {
      _handleDragEnd();
    }
    super.onDragEnd(event);
    priority = 0;
  }

  _handleDragEnd() {
    gameRef.ball.xDirection = dragRelativePosition.x.sign * -1;
    gameRef.ball.yDirection = -1;
    final newPosition = getNextPosition();
    gameRef.ball.nextPosition.setFrom(newPosition);

    if (gameRef.ball.ballState != BallState.release) {
      gameRef.ball.aimAngle = 0;
      gameRef.ball.ballState = BallState.release;
    }
  }

  Vector2 getNextPosition() {
    var newPointX = 0.0;
    var newPointY = 0.0;

    if (dragLineSlope > -1 && dragLineSlope < 1) {
      newPointX = centerPosition.x - dragLineSlope.sign * 5;
      newPointY = centerPosition.y + (dragLineSlope * (newPointX - centerPosition.x));
    } else {
      newPointY = centerPosition.y - 5;
      newPointX = (newPointY - centerPosition.y) / dragLineSlope + centerPosition.x;
    }

    return Vector2(
      dragLineSlope.sign * (centerPosition.x - newPointX),
      centerPosition.y - newPointY,
    );
  }

  void resetBoard() {
    dragLineSlope = 0;
    dragStartPosition.setZero();
    dragRelativePosition.setZero();
    gameRef.ball.ballState = BallState.idle;
  }

  void _movePaddle(DragUpdateEvent event) {
    gameRef.paddle.dragPaddle(event.localPosition.x);
  }
}
