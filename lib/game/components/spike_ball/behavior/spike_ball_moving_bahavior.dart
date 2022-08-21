import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flamejam/game/game.dart';

final _random = Random();

/// The [SpikeBall]s moving behavior is reflected here
class SpikeBallMovingBehavior extends Behavior<SpikeBall>
    with ParentIsA<SpikeBall>, HasGameRef<FlameJam> {
  @override
  Future<void>? onLoad() async {
    parent.bodyComponent.body.gravityScale = Vector2.zero();

    await add(
      TimerComponent(
        period: Random().nextDouble(),
        repeat: true,
        onTick: _moveSpikeBall,
      ),
    );
  }

  void _moveSpikeBall() {
    final body = parent.bodyComponent.body;
    body.applyLinearImpulse(
      Vector2(
        _random.nextDouble() * (_random.nextBool() ? 100 : -100),
        _random.nextDouble() * (_random.nextBool() ? 100 : -100),
      ).scaled(body.mass),
    );
  }
}
