import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Player extends BodyComponent with ParentIsA<Forge2DGame>, KeyboardHandler {
  /// Player Component which can move
  Player({
    required this.initialPosition,
  });

  static const double spriteWidth = 12;
  static const double spriteHeight = 16;

  static const double playerHeight = 8;
  static const double playerWidth = 6;

  final Vector2 initialPosition;
  final Vector2 velocity = Vector2(0, 0);
  final int speed = 10;

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

  @override
  void update(double dt) {
    super.update(dt);

    // rotate the player to have his feet on the ground where gravity points
    body.setTransform(body.position, pi - world.gravity.screenAngle() * -1);

    body.applyLinearImpulse(velocity.scaled(body.mass));
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
