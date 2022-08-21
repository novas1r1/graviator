import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// The [OxygenTank] allows the player to stay longer in the universe, if you collect them you receive O2 to survive
/// in space.
class OxygenTank extends BodyEntity {
  /// Creates a [OxygenTank] instance
  OxygenTank({
    required Vector2 initialPosition,
    super.behaviors,
  }) : super(
          bodyComponent: _OxygenTankComponent()..initialPosition = initialPosition,
        );

  /// Create a [OxygenTank] Entity from the [MiniMap] Entry
  OxygenTank.fromMapEntry({
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
  }) : this(
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
        );
}

class _OxygenTankComponent extends BodyComponent with InitialPosition, ContactCallbacks {
  _OxygenTankComponent()
      : super(
          renderBody: false,
          children: [
            SpriteComponent(
              sprite: MiniSpriteLibrary.sprites['oxygen_tank_label'],
              size: Vector2.all(4),
              anchor: Anchor.center,
              position: Vector2(0, _spriteSize.y * 0.1),
              priority: 1,
            ),
            SpriteComponent(
              size: _spriteSize,
              sprite: MiniSpriteLibrary.sprites['oxygen_tank'],
              anchor: Anchor.center,
              position: Vector2(_spriteSize.x * 0.005, 0),
              priority: 0,
            )
          ],
        );

  static final _spriteSize = Vector2.all(16);

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if (other is Astronaut) {
      readBloc<AstronautCubit, AstronautState>().pickUpOxygen();
      parent!.removeFromParent();
    }
  }

  @override
  void preSolve(Object other, Contact contact, Manifold oldManifold) {
    super.preSolve(other, contact, oldManifold);
    if (other is Astronaut) contact.setEnabled(false);
  }

  @override
  Body createBody() {
    final fixtureDef = FixtureDef(
      PolygonShape()
        ..setAsBoxXY(
          (_spriteSize.x / 2) * 0.5,
          (_spriteSize.y / 2) * 0.88,
        ),
    );
    return world.createBody(
      BodyDef(
        position: initialPosition,
        userData: this,
      ),
    )..createFixture(fixtureDef);
  }
}
