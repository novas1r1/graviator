import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// The [Bubble] allows the player to stay longer in the universe, if you collect them you receive O2 to survive
/// in space.
class Bubble extends BodyEntity {
  /// Creates a [Bubble] instance
  Bubble({
    required Vector2 initialPosition,
    super.behaviors,
  }) : super(
          bodyComponent: _BubbleComponent()..initialPosition = initialPosition,
        );

  /// Create a [Bubble] Entity from the [MiniMap] Entry
  Bubble.fromMapEntry({
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
  }) : this(
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
        );
}

class _BubbleComponent extends BodyComponent with InitialPosition, ContactCallbacks {
  _BubbleComponent()
      : super(
          renderBody: false,
          children: [
            SpriteComponent(
              size: _spriteSize,
              sprite: MiniSpriteLibrary.sprites['oxygen_bubble'],
              anchor: Anchor.center,
              position: Vector2(_spriteSize.x * 0.005, 0),
              priority: 0,
            )
          ],
        );

  static final _spriteSize = Vector2.all(6);

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
    paint.color = Color(0xFFFF00000);
    final fixtureDef = FixtureDef(
      CircleShape()..radius = _spriteSize.x / 2,
    );
    return world.createBody(
      BodyDef(
        position: initialPosition,
        userData: this,
      ),
    )..createFixture(fixtureDef);
  }
}
