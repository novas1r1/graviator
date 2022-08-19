// ignore_for_file: public_member_api_docs

import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Box extends Entity {
  Box()
      : super(
          children: [_BoxBody()],
        );
}

class _BoxBody extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: gameRef.size / 2,
    );

    return world.createBody(bodyDef)
      ..createFixtureFromShape(
        PolygonShape()..setAsBoxXY(10, 10),
      );
  }
}
