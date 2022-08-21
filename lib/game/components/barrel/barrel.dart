// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

export 'behaviors/behaviors.dart';

class Barrel extends BodyEntity {
  Barrel({
    required Vector2 initialPosition,
    super.behaviors,
  }) : super(bodyComponent: _BarrelBodyComponent()..initialPosition = initialPosition);

  Barrel.fromMapEntry({
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
  }) : this(
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
        );
}

class _BarrelBodyComponent extends BodyComponent with InitialPosition {
  _BarrelBodyComponent()
      : super(
          renderBody: false,
          children: [
            SpriteComponent(
              sprite: MiniSpriteLibrary.sprites['barrel'],
              position: Vector2.all(_spriteSize.x / -2),
            )
          ],
        );

  static final _spriteSize = Vector2.all(16);

  @override
  Body createBody() {
    return world.createBody(
      BodyDef(
        type: BodyType.dynamic,
        position: initialPosition,
      ),
    )..createFixtureFromShape(
        PolygonShape()..setAsBoxXY(_spriteSize.x / 2, _spriteSize.y / 2),
      );
  }
}
