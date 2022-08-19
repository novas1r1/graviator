import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

/// Rotates the [World.gravity] clockwise when [_keys] are pressed.
///
/// Whenever, the gravity is rotated, all the [World.bodies] lose their
/// velocity.
class GravityRotatorBehavior extends Component
    with ParentIsA<Forge2DGame>, KeyboardHandler {
  late final List<LogicalKeyboardKey> _keys = [LogicalKeyboardKey.space];

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (!_keys.contains(event.logicalKey)) {
      return true;
    }

    if (event is RawKeyUpEvent) {
      for (final body in parent.world.bodies) {
        body.linearVelocity.setZero();
      }
      parent.world.gravity.rotateClockwise();
    }

    return false;
  }
}

extension on Vector2 {
  void rotateClockwise() {
    // TODO(md-weber): use a better rotation algorithm
    if (x == 0 && y == 10) {
      x = -10;
      y = 0;
    } else if (x == -10 && y == 0) {
      x = 0;
      y = -10;
    } else if (x == 0 && y == -10) {
      x = 10;
      y = 0;
    } else if (x == 10 && y == 0) {
      x = 0;
      y = 10;
    }
  }
}
