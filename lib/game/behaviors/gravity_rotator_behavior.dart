import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/game.dart';

/// Rotates the [World.gravity].
///
/// Whenever, the gravity is rotated, all the [World.bodies] lose their
/// velocity.
class GravityRotatorBehavior extends Behavior<GameEntity> {
  void _rotateGravity() {
    final astronaut = parent.descendants().whereType<Astronaut>();
    for (final body in parent.game.world.bodies) {
      if (astronaut.isNotEmpty && body == astronaut.first.bodyComponent.body) {
        continue;
      }
      body.linearVelocity.setZero();
      body.setAwake(true);
    }
    parent.game.world.gravity.rotateAntiClockwise();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(
      TimerComponent(
        period: 8,
        repeat: true,
        onTick: _rotateGravity,
      ),
    );
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
