import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// This portal will finish the game and show the "Win Screen" screen
class Portal extends BodyEntity {
  /// Create a Portal Entity
  Portal({required Vector2 initialPosition})
      : super(
          bodyComponent: _PortalBodyComponent()..initialPosition = initialPosition,
        );

  /// creates a box from an entry of a map
  factory Portal.fromMapEntry({required MapEntry<MapPosition, Map<String, dynamic>> entry}) {
    final position = Vector2(
      entry.key.x.toDouble() * 16,
      entry.key.y.toDouble() * 16,
    );

    return Portal(initialPosition: position);
  }
}

class _PortalBodyComponent extends BodyComponent with InitialPosition {
  @override
  Body createBody() {
    final fixtureDef = FixtureDef(PolygonShape()..setAsBoxXY(16, 16), isSensor: true, userData: this);
    final bodyDef = BodyDef(position: initialPosition);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
