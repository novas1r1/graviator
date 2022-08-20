import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flutter/services.dart';

class ControlledMovementBehavior extends Behavior<Player>
    with ParentIsA<Player>, KeyboardHandler {
  ControlledMovementBehavior({
    this.speed = 10,
  });

  final int speed;
  final Vector2 velocity = Vector2(0, 0);

  @override
  void update(double dt) {
    super.update(dt);

    final body = parent.body;

    // rotate the player to have his feet on the ground where gravity points
    body
        // .setTransform(body.position, pi - world.gravity.screenAngle() * -1)
        .applyLinearImpulse(velocity.scaled(body.mass));
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      velocity.x = isKeyDown ? -1 : 0;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      velocity.x = isKeyDown ? 1 : 0;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      velocity.y = isKeyDown ? -1 : 0;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      velocity.y = isKeyDown ? 1 : 0;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
