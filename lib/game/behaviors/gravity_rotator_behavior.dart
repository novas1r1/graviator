import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter/services.dart';

/// Rotates the [World.gravity] clockwise when [_keys] are pressed.
///
/// Whenever, the gravity is rotated, all the [World.bodies] lose their
/// velocity.
class GravityRotatorBehavior extends Behavior<GameEntity> with KeyboardHandler {
  late final List<LogicalKeyboardKey> _keys = [LogicalKeyboardKey.space];

  @override
  // ignore: avoid_renaming_method_parameters
  bool onKeyEvent(RawKeyEvent event, _) {
    if (event is! RawKeyUpEvent) return true;
    if (!_keys.contains(event.logicalKey)) return true;

    for (final body in parent.game.world.bodies) {
      body.linearVelocity.setZero();
      body.setAwake(true);
    }
    parent.game.world.gravity.rotateAntiClockwise();

    return true;
  }
}

extension on Vector2 {
  void rotateAntiClockwise() {
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
