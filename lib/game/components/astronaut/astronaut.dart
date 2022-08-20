// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/helpers/helpers.dart';

export 'behaviors/behaviors.dart';

class Astronaut extends BodyEntity<AstronautBodyComponent> {
  Astronaut({
    required Vector2 initialPosition,
    super.behaviors,
    super.children,
  }) : super(
          bodyComponent: AstronautBodyComponent()..initialPosition = initialPosition,
        );
}

class AstronautBodyComponent extends BodyComponent with InitialPosition {
  AstronautBodyComponent()
      : super(
          renderBody: false,
          children: [
            SpriteComponent(
              sprite: MiniSpriteLibrary.sprites['player'],
              size: _spriteSize,
              position: Vector2(
                _spriteSize.x / -2,
                (_spriteSize.y / -2) - (_spriteSize.y * 0.03),
              ),
            ),
          ],
        );

  static final _spriteSize = Vector2.all(16);

  @override
  Body createBody() {
    final fixture = FixtureDef(
      PolygonShape()..setAsBoxXY(_spriteSize.x * 0.37, _spriteSize.y * 0.47),
      friction: 1,
      density: 0.1,
    );

    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: initialPosition,
      allowSleep: false,
      fixedRotation: true,
      userData: parent,
    );

    return world.createBody(bodyDef)..createFixture(fixture);
  }
}
