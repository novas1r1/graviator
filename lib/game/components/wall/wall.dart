import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// [Wall] to get exposed to the universe
class Wall extends BodyEntity {
  /// The Ship [Wall]
  Wall({required Vector2 initialPosition})
      : super(bodyComponent: _WallBodyComponent()..initialPosition = initialPosition);

  /// Create a [Wall] Entity from the [MiniMap] Entry
  Wall.fromMapEntry({required MapEntry<MapPosition, Map<String, dynamic>> entry})
      : this(
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
        );
}

class _WallBodyComponent extends BodyComponent with InitialPosition {
  _WallBodyComponent()
      : super(renderBody: true, children: [
          SpriteComponent(
            sprite: MiniSpriteLibrary.sprites['wall_corner_top_left'],
          )
        ]);

  static final Vector2 _spriteSize = Vector2.all(16);

  @override
  Body createBody() {
    paint.color = const Color(0xFFFF0000);

    final fixtureDefTop = FixtureDef(
      PolygonShape()
        ..setAsBox(
          (_spriteSize.x / 2),
          (_spriteSize.y / 2) * 0.15,
          Vector2(_spriteSize.x / 2, _spriteSize.y / 2 * 0.25),
          0,
        ),
    );

    final fixtureDefLeft = FixtureDef(
      PolygonShape()
        ..setAsBox(
          (_spriteSize.x / 2) * 0.15,
          (_spriteSize.y / 2),
          Vector2(_spriteSize.x / 2 * 0.25, (_spriteSize.y / 2)),
          0,
        ),
    );

    final bodyDef = BodyDef(
      userData: this,
      position: initialPosition,
    );

    return world.createBody(bodyDef)
      ..createFixture(fixtureDefTop)
      ..createFixture(fixtureDefLeft);
  }
}
