import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:flutter/material.dart';

/// Player Entity which can move
class Player extends BodyEntity {
  /// Constructor
  Player({
    required Vector2 initialPosition,
    super.behaviors,
  }) : super(
          bodyComponent: _PlayerBodyComponent()
            ..initialPosition = initialPosition,
        );
}

class _PlayerBodyComponent extends BodyComponent with InitialPosition {
  static const double playerHeight = 32;
  static const double playerWidth = 32;

  @override
  Body createBody() {
    final fixture = FixtureDef(
      PolygonShape()
        ..setAsBoxXY(
          playerWidth / 2,
          playerHeight / 2,
        ),
      friction: 1,
      density: 0.1,
      userData: this,
    );

    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: initialPosition,
      allowSleep: false,
      fixedRotation: true,
      userData: this,
    );

    final body = world.createBody(bodyDef)..createFixture(fixture);

    add(
      SpriteComponent(
        sprite: MiniSpriteLibrary.sprites['player'],
        size: Vector2(playerWidth, playerHeight),
        position: Vector2(playerWidth / 2, playerHeight / 2)..negate(),
      ),
    );

    paint.color = Colors.transparent;

    return body;
  }
}
