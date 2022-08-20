import 'package:flame_forge2d/flame_forge2d.dart';

class Player extends BodyComponent {
  Player({required this.position});

  final Vector2 position;

  @override
  Body createBody() {
    final fixture = FixtureDef(
      CircleShape()..radius = 2,
      friction: 0.3,
      restitution: 0.6,
      density: 1,
    );

    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: position,
    );

    return world.createBody(bodyDef)..createFixture(fixture);
  }
}
