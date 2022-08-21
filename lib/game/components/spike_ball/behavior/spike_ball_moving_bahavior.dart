import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flamejam/game/components/spike_ball/spike_ball.dart';
import 'package:flamejam/game/game.dart';

/// The [SpikeBall]s moving behavior is reflected here
class SpikeBallMovingBehavior extends Behavior<SpikeBall> with ParentIsA<SpikeBall>, HasGameRef<FlameJam> {
  @override
  Future<void>? onLoad() async {
    parent.bodyComponent.body.gravityScale = Vector2.zero();

    await add(
      TimerComponent(period: Random().nextDouble(), repeat: true, onTick: _moveSpikeBall),
    );
  }

  void _moveSpikeBall() {
    final body = parent.bodyComponent.body;
    final rng = Random();
    body.applyLinearImpulse(
      Vector2(
        rng.nextDouble() * (rng.nextBool() ? 100 : -100),
        rng.nextDouble() * (rng.nextBool() ? 100 : -100),
      ).scaled(body.mass),
    );
  }
}
