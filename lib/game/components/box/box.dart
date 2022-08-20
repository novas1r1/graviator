// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

export 'behaviors/behaviors.dart';

class Box extends BodyEntity {
  Box({
    required BodyType type,
    required Vector2 initialPosition,
    super.behaviors,
  }) : super(
          bodyComponent: _BoxBodyComponent(type: type)
            ..initialPosition = initialPosition,
        );

  /// creates a box from an entry of a map
  factory Box.fromMapEntry({
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
    required BodyType bodyType,
  }) {
    final position = Vector2(
      entry.key.x.toDouble() * defaultWidth,
      entry.key.y.toDouble() * defaultHeight,
    );

    return Box(
      initialPosition: position,
      type: bodyType,
    );
  }

  /// default height
  static const double defaultHeight = 16;

  /// default width
  static const double defaultWidth = 16;

  static List<Box> createAllFromMap(
    MiniMap map,
  ) {
    final boxes = <Box>[];

    for (final entry in map.objects.entries) {
      final spriteName = entry.value['sprite'];

      BodyType bodyType;

      switch (spriteName) {
        case 'building_block_static':
          bodyType = BodyType.static;
          break;
        case 'building_block_dynamic':
          bodyType = BodyType.dynamic;
          break;
        default:
          continue;
      }

      boxes.add(
        Box.fromMapEntry(
          entry: entry,
          bodyType: bodyType,
        ),
      );
    }

    return boxes;
  }
}

class _BoxBodyComponent extends BodyComponent with InitialPosition {
  _BoxBodyComponent({
    required BodyType type,
  })  : _type = type,
        super(
          children: [
            if (type == BodyType.static) _BoxBodySpriteComponent.static(),
            if (type == BodyType.dynamic) _BoxBodySpriteComponent.dynamic(),
          ],
        );

  final BodyType _type;

  @override
  Body createBody() {
    return world.createBody(
      BodyDef(
        type: _type,
        position: initialPosition,
      ),
    )..createFixtureFromShape(
        PolygonShape()..setAsBoxXY(Box.defaultWidth / 2, Box.defaultHeight / 2),
      );
  }
}

class _BoxBodySpriteComponent extends SpriteComponent {
  _BoxBodySpriteComponent.dynamic()
      : super(
          sprite: MiniSpriteLibrary.sprites['building_block_dynamic'],
        );

  _BoxBodySpriteComponent.static()
      : super(
          sprite: MiniSpriteLibrary.sprites['building_block_static'],
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    position = size.clone() / -2;
  }
}
