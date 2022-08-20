import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/behaviors/gravity_rotator_behavior.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flutter/material.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// the main game class
class FlameJam extends Forge2DGame with HasKeyboardHandlerComponents {
  /// default constructor
  FlameJam() : super(gravity: Vector2(0, 10));

  @override
  Color backgroundColor() => const Color.fromARGB(255, 0, 88, 255);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await MiniSpriteLibrary.loadSprites(pixelSize: 1, color: Colors.amber);

    await addAll([
      GravityRotatorBehavior(),
      Player(initialPosition: Vector2(50, 50)),
      Box(
        type: BodyType.dynamic,
        behaviors: [
          BoxBouncingBehavior(),
        ],
      ),
      // WallStatic(position: WallPosition.top),
      // WallStatic(position: WallPosition.left),
      // WallStatic(position: WallPosition.right),
      // WallStatic(position: WallPosition.bottom),
    ]);

    final componentLoadingFutures = <Future<dynamic>>[];

    final map = MiniMap.fromDataString(MiniSpriteMaps.demoLevel);

    for (final element in map.objects.entries) {
      componentLoadingFutures
          .add(addAll(BuildingBlockFactory.resolveMapEntry(element)));
    }

    await Future.wait(componentLoadingFutures);

    camera.zoom = 4;
  }

  // TODO(dev): later on, typing the map elements would be a better approach

  /// small method to avoid typos when accessing sprite entry in map elements
  String? getSpriteNameFromMapElement(
    MapEntry<MapPosition, Map<String, dynamic>> element,
  ) {
    return element.value['sprite'] as String?;
  }
}
