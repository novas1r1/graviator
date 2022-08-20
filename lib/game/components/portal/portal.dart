import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// This portal will finish the game and show the "Win Screen" screen
class Portal extends BodyEntity {
  /// Create a Portal Entity
  Portal({required Vector2 initialPosition})
      : super(
          bodyComponent: _PortalBodyComponent()..initialPosition = initialPosition,
        );

  /// Create a [Portal] Entity from the [MiniMap] Entry
  Portal.fromMapEntry({required MapEntry<MapPosition, Map<String, dynamic>> entry})
      : this(
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
        );
}

class _PortalBodyComponent extends BodyComponent with InitialPosition {
  static final _spriteSize = Vector2.all(8);

  _PortalBodyComponent()
      : super(children: [
          SpriteComponent(
            sprite: MiniSpriteLibrary.sprites['portal'],
            size: _spriteSize,
            // position: _spriteSize.clone() / 2,
          )
        ]);

  @override
  Body createBody() {
    final fixtureDef = FixtureDef(
      PolygonShape()..setAsBoxXY(_spriteSize.x, _spriteSize.y),
      userData: this,
    );
    final bodyDef = BodyDef(position: initialPosition);
    paint.color = Color(0xFFFF00000);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
