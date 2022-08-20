// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flamejam/game/components/astronaut/astronaut.dart';
import 'package:flamejam/game/components/jetpack/jetpack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JetpackPropulsingBehavior extends Behavior<Jetpack> with KeyboardHandler {
  JetpackPropulsingBehavior();

  late final List<LogicalKeyboardKey> _keys = [LogicalKeyboardKey.keyW];

  @override
  // ignore: avoid_renaming_method_parameters
  bool onKeyEvent(RawKeyEvent event, _) {
    if (!_keys.contains(event.logicalKey)) return true;

    final astronaut = parent.parent;
    if (event is RawKeyDownEvent) {
      astronaut.body.applyLinearImpulse(
        Vector2(0, -4 * astronaut.body.mass),
      );

      add(
        _SmokeParticleSystem(
          size: AstronautBodyComponent.spriteSize,
          count: astronaut.body.linearVelocity.length.ceil(),
          acceleration: Vector2(
            -astronaut.body.linearVelocity.x,
            -astronaut.body.linearVelocity.y.abs(),
          ),
        ),
      );
    }

    return true;
  }
}

class _SmokeParticleSystem extends ParticleSystemComponent {
  _SmokeParticleSystem({required int count, required Vector2 acceleration, required Vector2 size})
      : super(
          // TODO(alestiago): Remove this absolute positioning.
          position: Vector2(size.x - 12, size.y - 11),
          particle: Particle.generate(
            count: count,
            generator: (i) => AcceleratedParticle(
              speed: Vector2(0, 50),
              acceleration: acceleration,
              child: _SquareParticle(
                lifespan: 0.3,
                size: 1,
                paint: Paint()..color = Colors.white,
              ),
            ),
          ),
        ) {}
}

class _SquareParticle extends Particle {
  _SquareParticle({
    required this.paint,
    required this.size,
    super.lifespan,
  });

  final Paint paint;
  final double size;

  @override
  void render(Canvas c) {
    c.drawRect(Rect.fromLTWH(0, 0, size, size), paint);
  }
}
