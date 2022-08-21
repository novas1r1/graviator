import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flamejam/game/components/bubble/bubble.dart';

class BubbleWiggleBehavior extends Behavior<Bubble> {
  @override
  Future<void>? onLoad() {
    parent.bodyComponent.body.gravityScale = Vector2.zero();
    add(
      TimerComponent(period: 0.1, onTick: _onTick),
    );
    return super.onLoad();
  }

  void _onTick() {
    parent.bodyComponent.body.applyLinearImpulse(
      Vector2(
        Random().nextDouble() * (Random().nextBool() ? 2 : -2),
        Random().nextDouble() * (Random().nextBool() ? 2 : -2),
      )..scale(parent.bodyComponent.body.mass),
    );
  }
}
