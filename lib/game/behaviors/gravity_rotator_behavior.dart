import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

/// Rotates the [World.gravity] clockwise when [_keys] are pressed.
///
/// Whenever, the gravity is rotated, all the [World.bodies] lose their
/// velocity.
class GravityRotatorBehavior extends Component with ParentIsA<Forge2DGame>, KeyboardHandler {
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
        body.setAwake(true);
      }
      parent.world.gravity.rotateClockwise();
    }

    return false;
  }
}

extension on Vector2 {
  void rotateClockwise() {
    final x = this.x;
    final y = this.y;

    if (x == 0 && y == 10) {
      this.x = -y;
      this.y = x;
    } else if (x == -10 && y == 0) {
      this.x = y;
      this.y = x;
    } else if (x == 0 && y == -10) {
      this.x = -y;
      this.y = x;
    } else if (x == 10 && y == 0) {
      this.x = y;
      this.y = x;
    }
  }
}
