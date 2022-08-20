import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Player extends BodyComponent with ParentIsA<Forge2DGame>, KeyboardHandler {
  /// Player Component which can move
  Player({
    required this.initialPosition,
  }) : super() {
    paint.color = Colors.blue;
  }

  final Vector2 initialPosition;
  final Vector2 velocity = Vector2(0, 0);
  final int speed = 10;

  @override
  Body createBody() {
    final fixture = FixtureDef(
      CircleShape()..radius = 2,
      friction: 0.3,
      restitution: 0.6,
      density: 1,
      userData: this,
    );

    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: initialPosition,
      userData: this,
      allowSleep: false,
    );

    return world.createBody(bodyDef)..createFixture(fixture);
  }

  @override
  void update(double dt) {
    super.update(dt);

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
