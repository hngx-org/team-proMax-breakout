import 'dart:ui';

import 'package:bluck_buster/features/game/game_page.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Paddle extends Component {
  static const double width = 20;
  static const double height = 40;
  double x = 0;

  void moveLeft() {
    if (x > 0) {
      x -= 1; // Adjust the speed and direction as needed.
    }
  }

  void moveRight(double gameWidth) {
    if (x + width < gameWidth) {
      x += 1; // Adjust the speed and direction as needed.
    }
  }

  @override
  void render(Canvas canvas) {
    double centerX = (game.size.x - width) / 2;
    canvas.drawRect(
      Rect.fromLTWH(centerX, game.size.y - height, width, height),
      Paint()
        ..color = const Color(0xFF00FF00), // Adjust color as needed.
    );
  }

  @override
  void update(double t) {
    // Update logic here if needed
  }
}
