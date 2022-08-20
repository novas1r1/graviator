import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/helpers/helpers.dart';

/// Player Entity which can move
class Player extends BodyEntity {
  /// Constructor
  Player({
    required Vector2 initialPosition,
    super.behaviors,
  }) : super(
          bodyComponent: _PlayerBodyComponent()
            ..initialPosition = initialPosition,
        );
}

class _PlayerBodyComponent extends BodyComponent with InitialPosition {
  _PlayerBodyComponent()
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

  static final _spriteSize = Vector2.all(32);

  @override
  Body createBody() {
    final hitbox = Vector2(
      _spriteSize.x * 0.37,
      _spriteSize.y * 0.47,
    );
    final fixture = FixtureDef(
      PolygonShape()..setAsBoxXY(hitbox.x, hitbox.y),
      friction: 1,
      density: 0.1,
    );

    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: initialPosition,
      allowSleep: false,
      fixedRotation: true,
      userData: this,
    );

    return world.createBody(bodyDef)..createFixture(fixture);
  }
}
