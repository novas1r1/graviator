import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

class Oxygen extends BodyEntity {
  Oxygen({
    required Vector2 initialPosition,
    super.behaviors,
  }) : super(
          bodyComponent: _OxygenComponent()..initialPosition = initialPosition,
        );

  factory Oxygen.fromMapEntry({
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
    required double mapWidth,
    required double mapHeight,
  }) {
    final position = Vector2(
      entry.key.x.toDouble() * mapWidth,
      entry.key.y.toDouble() * mapHeight,
    );

    return Oxygen(
      initialPosition: position,
    );
  }

  /// default height
  static const double defaultHeight = 16;

  /// default width
  static const double defaultWidth = 12;

  static List<Oxygen> createAllFromMap(
    MiniMap map,
  ) {
    final oxygenList = <Oxygen>[];

    for (final entry in map.objects.entries) {
      final spriteName = entry.value['sprite'];

      if (spriteName != 'oxygen') continue;

      oxygenList.add(
        Oxygen.fromMapEntry(
          entry: entry,
          mapHeight: 16,
          mapWidth: 16,
        ),
      );
    }

    return oxygenList;
  }
}

class _OxygenComponent extends BodyComponent with InitialPosition {
  _OxygenComponent()
      : super(
          children: [
            _OxygenSpriteComponent(),
          ],
        );

  @override
  Body createBody() {
    return world.createBody(
      BodyDef(position: initialPosition),
    )..createFixtureFromShape(
        PolygonShape()
          ..setAsBoxXY(Oxygen.defaultWidth / 2, Oxygen.defaultHeight / 2),
      );
  }
}

class _OxygenSpriteComponent extends SpriteComponent {
  _OxygenSpriteComponent()
      : super(
          sprite: MiniSpriteLibrary.sprites['oxygen'],
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    position = size.clone() / -2;
  }
}
