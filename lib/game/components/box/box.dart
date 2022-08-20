// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/helpers/helpers.dart';

export 'behaviors/behaviors.dart';

class Box extends BodyEntity {
  Box({
    required BodyType type,
    required Vector2 initialPosition,
    super.behaviors,
  }) : super(
          bodyComponent: _BoxBodyComponent(type: type)
            ..initialPosition = initialPosition,
        );
}

class _BoxBodyComponent extends BodyComponent with InitialPosition {
  _BoxBodyComponent({
    required BodyType type,
  })  : _type = type,
        super(
          children: [
            if (type == BodyType.static) _BoxBodySpriteComponent.static(),
            if (type == BodyType.dynamic) _BoxBodySpriteComponent.dynamic(),
          ],
        );

  final BodyType _type;

  @override
  Body createBody() {
    return world.createBody(
      BodyDef(
        type: _type,
        position: initialPosition,
      ),
    )..createFixtureFromShape(
        PolygonShape()..setAsBoxXY(10, 10),
      );
  }
}

class _BoxBodySpriteComponent extends SpriteComponent {
  _BoxBodySpriteComponent.dynamic()
      : super(
          sprite: MiniSpriteLibrary.sprites['building_block_dynamic'],
        );

  _BoxBodySpriteComponent.static()
      : super(
          sprite: MiniSpriteLibrary.sprites['building_block_static'],
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = size.clone() / -2;
  }
}
