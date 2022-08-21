import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// The [Spike] is a trap for the player, if he falls into the spikes he will die and the game will stop.
class Spike extends BodyEntity {
  /// Create a Spike Body Entity
  Spike({required Vector2 initialPosition})
      : super(
          bodyComponent: _SpikeBodyComponent()
            ..initialPosition = initialPosition,
        );

  /// Create a [Spike] Entity from the [MiniMap] Entry
  Spike.fromMapEntry({
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
  }) : this(
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
        );
}

class _SpikeBodyComponent extends BodyComponent with InitialPosition {
  _SpikeBodyComponent()
      : super(
          renderBody: true,
        );

  static final _spriteSize = Vector2.all(16);

  @override
  Body createBody() {
    paint.color = const Color(0xFFFF0000);
    final bodyDef = BodyDef(position: initialPosition);

    final fixtureDef = FixtureDef(
      PolygonShape()
        ..setAsBoxXY(
          (_spriteSize.x / 2) * 0.60,
          (_spriteSize.y / 2) * 0.88,
        ),
      userData: this,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
