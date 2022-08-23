// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/game.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

export 'behaviors/behaviors.dart';
export 'cubit/astronaut_cubit.dart';

class Astronaut extends BodyEntity<AstronautBodyComponent> {
  Astronaut({
    required Vector2 initialPosition,
  }) : super(
          bodyComponent: AstronautBodyComponent()
            ..initialPosition = initialPosition,
          children: [
            Jetpack(
              behaviors: [JetpackPropulsingBehavior()],
            ),
          ],
          behaviors: [
            AstronautFollowerBehavior(),
            ControlledMovementBehavior(),
          ],
        );

  /// Create an [Astronaut] entity from the [MiniMap] Entry
  Astronaut.fromMapEntry({
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
  }) : this(
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
        );
}

class AstronautBodyComponent extends BodyComponent with InitialPosition {
  AstronautBodyComponent()
      : super(
          renderBody: false,
          children: [AstronautSprite(spriteSize: spriteSize)],
        );

  static final spriteSize = Vector2.all(16);

  @override
  Body createBody() {
    final fixture = FixtureDef(
      PolygonShape()..setAsBoxXY(spriteSize.x * 0.37, spriteSize.y * 0.47),
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

enum Direction { left, right }

class AstronautSprite extends SpriteComponent
    with ParentIsA<AstronautBodyComponent> {
  AstronautSprite({required Vector2 spriteSize})
      : super(
          sprite: MiniSpriteLibrary.sprites['player'],
          size: spriteSize,
          position: Vector2(
            spriteSize.x / -2,
            (spriteSize.y / -2) - (spriteSize.y * 0.03),
          ),
        );
  Direction viewDirection = Direction.left;

  @override
  void update(double dt) {
    if (parent.body.linearVelocity.x.ceil() > 0 &&
        viewDirection == Direction.left) {
      flipHorizontallyAroundCenter();
      viewDirection = Direction.right;
    }
    if (parent.body.linearVelocity.x.ceil() < 0 &&
        viewDirection == Direction.right) {
      flipHorizontallyAroundCenter();
      viewDirection = Direction.left;
    }
    super.update(dt);
  }
}
