import 'package:flame_forge2d/flame_forge2d.dart';

/// A wall which is not affected by gravity and can't be moved.
class WallStatic extends BodyComponent {
  /// Position of the wall can be top, left, right or bottom.
  /// It always takes the full width and height of the screen.
  WallStatic({required this.position});

  /// Top, left, right or bottom
  final WallPosition position;

  @override
  Body createBody() {
    final fixture = FixtureDef(
      PolygonShape()..setAsBoxXY(_getWidth(), _getHeight()),
    );

    final bodyDef = BodyDef(
      position: _getPosition(),
    );

    return world.createBody(bodyDef)..createFixture(fixture);
  }

  double _getWidth() {
    switch (position) {
      case WallPosition.top:
      case WallPosition.bottom:
        return 100;
      case WallPosition.left:
      case WallPosition.right:
        return 4;
    }
  }

  double _getHeight() {
    switch (position) {
      case WallPosition.top:
      case WallPosition.bottom:
        return 4;
      case WallPosition.left:
      case WallPosition.right:
        return 100;
    }
  }

  Vector2 _getPosition() {
    switch (position) {
      case WallPosition.top:
        return Vector2(0, 0);
      case WallPosition.bottom:
        return Vector2(0, gameRef.size.y);
      case WallPosition.left:
        return Vector2(0, 0);
      case WallPosition.right:
        return Vector2(gameRef.size.x, 0);
    }
  }
}

/// Position of the wall
enum WallPosition {
  /// sticks to the top of the screen
  top,

  /// sticks to the left of the screen
  left,

  /// sticks to the right of the screen
  right,

  /// sticks to the bottom of the screen
  bottom,
}
