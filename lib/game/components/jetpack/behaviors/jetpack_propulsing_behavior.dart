// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flamejam/game/components/astronaut/astronaut.dart';
import 'package:flamejam/game/components/jetpack/jetpack.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JetpackPropulsingBehavior extends Behavior<Jetpack>
    with KeyboardHandler, HasGameRef<Forge2DGame> {
  JetpackPropulsingBehavior();

  late final List<LogicalKeyboardKey> _keys = [LogicalKeyboardKey.space];

  bool _facingRight = false;

  Vector2 getFlightDirectionDependingOnGravity() {
    final gravityDirectionY = gameRef.world.gravity.y;
    final gravityDirectionX = gameRef.world.gravity.x;

    final isGravityLeft = gravityDirectionX == -10;
    final isGravityUp = gravityDirectionY == -10;
    final isGravityRight = gravityDirectionX == 10;

    if (isGravityLeft) return Vector2(4, 0);
    if (isGravityUp) return Vector2(0, 4);
    if (isGravityRight) return Vector2(-4, 0);
    return Vector2(0, -4);
  }

  @override
  void update(double dt) {
    super.update(dt);

    final astronautBody = parent.parent.body;
    _facingRight = astronautBody.linearVelocity.x.ceil() > 0;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  bool onKeyEvent(RawKeyEvent event, _) {
    if (!_keys.contains(event.logicalKey)) return true;

    final astronaut = parent.parent;
    if (event is RawKeyDownEvent) {
      readBloc<AstronautCubit, AstronautState>().reduceOxygen();

      astronaut.body.applyLinearImpulse(
        getFlightDirectionDependingOnGravity()..scale(astronaut.body.mass),
      );

      add(
        _SmokeParticleSystem(
          size: AstronautBodyComponent.spriteSize,
          mirror: _facingRight,
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
  _SmokeParticleSystem({
    required int count,
    required Vector2 acceleration,
    required bool mirror,
    required Vector2 size,
  }) : super(
          position: mirror
              ? Vector2(size.x - 21, size.y - 11)
              : Vector2(size.x - 12, size.y - 11),
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
        );
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
