import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// Oxygen
class OxygenTank extends BodyEntity {
  OxygenTank({
    required Vector2 initialPosition,
    super.behaviors,
  }) : super(
          bodyComponent: _OxygenTankComponent()
            ..initialPosition = initialPosition,
        );
  factory OxygenTank.fromMapEntry({
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
    required double mapWidth,
    required double mapHeight,
  }) {
    final position = Vector2(
      entry.key.x.toDouble() * mapWidth,
      entry.key.y.toDouble() * mapHeight,
    );

    return OxygenTank(initialPosition: position);
  }

  /// default height
  static const double defaultHeight = 16;

  /// default width
  static const double defaultWidth = 12;

  /// Goes through the whole map and creates oxygen tanks
  static List<OxygenTank> createAllFromMap(
    MiniMap map,
  ) {
    final oxygenList = <OxygenTank>[];

    for (final entry in map.objects.entries) {
      final spriteName = entry.value['sprite'];

      if (spriteName != 'oxygen_tank') continue;

      oxygenList.add(
        OxygenTank.fromMapEntry(
          entry: entry,
          mapHeight: 16,
          mapWidth: 16,
        ),
      );
    }

    return oxygenList;
  }
}

class _OxygenTankComponent extends BodyComponent
    with InitialPosition, ContactCallbacks {
  _OxygenTankComponent()
      : super(
          children: [
            _OxygenTankSpriteComponent(),
          ],
        ) {
    paint.color = Colors.blue;
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    parent!.removeFromParent();
  }

  @override
  Body createBody() {
    return world.createBody(
      BodyDef(
        position: initialPosition,
        userData: this,
      ),
    )..createFixtureFromShape(
        PolygonShape()
          ..setAsBoxXY(
            OxygenTank.defaultWidth / 2,
            OxygenTank.defaultHeight / 2,
          ),
      );
  }
}

class _OxygenTankSpriteComponent extends SpriteComponent {
  _OxygenTankSpriteComponent()
      : super(
          sprite: MiniSpriteLibrary.sprites['oxygen_tank'],
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    position = size.clone() / -2;
  }
}
