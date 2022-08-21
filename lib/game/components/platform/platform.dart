// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

class Platform extends BodyEntity {
  Platform({required Vector2 initialPosition})
      : super(bodyComponent: _PlatformBodyComponent()..initialPosition = initialPosition);

  Platform.fromMapEntry({
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
  }) : this(
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
        );

  /// default height
  static const double defaultHeight = 16;

  /// default width
  static const double defaultWidth = 16;
}

class _PlatformBodyComponent extends BodyComponent with InitialPosition {
  _PlatformBodyComponent()
      : super(
          renderBody: false,
          children: [
            SpriteComponent(sprite: MiniSpriteLibrary.sprites['platform'], position: Vector2.all(_spriteSize.x / -2))
          ],
        );

  static final _spriteSize = Vector2.all(16);

  @override
  Body createBody() {
    return world.createBody(
      BodyDef(position: initialPosition),
    )..createFixtureFromShape(
        PolygonShape()..setAsBoxXY(Platform.defaultWidth / 2, Platform.defaultHeight / 2),
      );
  }
}
