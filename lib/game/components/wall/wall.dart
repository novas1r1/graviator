import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// The [WallDirection] contains all possible wall directions
enum WallDirection {
  left,
  right,
  top,
  bottom,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight
}

/// [Wall] to get exposed to the universe
class Wall extends BodyEntity {
  /// The Ship [Wall]
  Wall({
    required Vector2 initialPosition,
    required WallDirection wallDirection,
    required String spriteName,
  }) : super(
          bodyComponent: _WallBodyComponent(
            wallDirection: wallDirection,
            spriteName: spriteName,
          )..initialPosition = initialPosition,
        );

  /// Create a [Wall] Entity from the [MiniMap] Entry
  Wall.fromMapEntry({
    required String spriteName,
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
    required WallDirection wallDirection,
  }) : this(
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
          wallDirection: wallDirection,
          spriteName: spriteName,
        );
}

class _WallBodyComponent extends BodyComponent with InitialPosition {
  _WallBodyComponent({required this.wallDirection, required String spriteName})
      : super(
          renderBody: false,
          children: [
            SpriteComponent(
              sprite: MiniSpriteLibrary.sprites[spriteName],
            )
          ],
        );

  WallDirection wallDirection;
  static final Vector2 _spriteSize = Vector2.all(16);

  bool get checkWallDirectionTop =>
      wallDirection == WallDirection.top ||
      wallDirection == WallDirection.topLeft ||
      wallDirection == WallDirection.topRight;

  bool get checkWallDirectionLeft =>
      wallDirection == WallDirection.left ||
      wallDirection == WallDirection.topLeft ||
      wallDirection == WallDirection.bottomLeft;

  bool get checkWallDirectionRight =>
      wallDirection == WallDirection.right ||
      wallDirection == WallDirection.topRight ||
      wallDirection == WallDirection.bottomRight;

  bool get checkWallDirectionBottom =>
      wallDirection == WallDirection.bottom ||
      wallDirection == WallDirection.bottomRight ||
      wallDirection == WallDirection.bottomLeft;

  @override
  Body createBody() {
    paint.color = const Color(0xFFFF0000);
    final fixtureDefs = <FixtureDef>[];

    if (checkWallDirectionTop) {
      fixtureDefs.add(
        FixtureDef(
          PolygonShape()
            ..setAsBox(
              (_spriteSize.x / 2),
              (_spriteSize.y / 2) * 0.15,
              Vector2(_spriteSize.x / 2, _spriteSize.y / 2 * 0.25),
              0,
            ),
        ),
      );
    }

    if (checkWallDirectionLeft) {
      fixtureDefs.add(
        FixtureDef(
          PolygonShape()
            ..setAsBox(
              (_spriteSize.x / 2) * 0.15,
              (_spriteSize.y / 2),
              Vector2(_spriteSize.x / 2 * 0.25, (_spriteSize.y / 2)),
              0,
            ),
        ),
      );
    }

    if (checkWallDirectionRight) {
      fixtureDefs.add(
        FixtureDef(
          PolygonShape()
            ..setAsBox(
              (_spriteSize.x / 2) * 0.15,
              (_spriteSize.y / 2),
              Vector2(_spriteSize.x * 0.9, _spriteSize.y * 0.5),
              0,
            ),
        ),
      );
    }

    if (checkWallDirectionBottom) {
      fixtureDefs.add(
        FixtureDef(
          PolygonShape()
            ..setAsBox(
              (_spriteSize.x / 2),
              (_spriteSize.y / 2) * 0.15,
              Vector2(_spriteSize.x * 0.5, _spriteSize.y * 0.9),
              0,
            ),
        ),
      );
    }

    final bodyDef = BodyDef(
      userData: this,
      position: initialPosition,
    );

    final wallBody = world.createBody(bodyDef);

    for (final fixture in fixtureDefs) {
      wallBody.createFixture(fixture);
    }

    return wallBody;
  }
}
