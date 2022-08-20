import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_mini_sprite/flame_mini_sprite.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/behaviors/gravity_rotator_behavior.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// the main game class
class FlameJam extends Forge2DGame with HasKeyboardHandlerComponents {
  /// default constructor
  FlameJam() : super(gravity: Vector2(0, 10));

  @override
  Color backgroundColor() => Color.fromARGB(255, 0, 88, 255);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await addAll([
      GravityRotatorBehavior(),
      Box(),
      WallStatic(position: WallPosition.top),
      WallStatic(position: WallPosition.left),
      WallStatic(position: WallPosition.right),
      WallStatic(position: WallPosition.bottom),
    ]);

    final componentLoadingFutures = <Future>[];

    final map = MiniMap.fromDataString(MiniSpriteMaps.demoLevel);

    final sprites = await MiniSpriteLibrary.library.toSprites(
      pixelSize: 1,
      color: Colors.white,
    );

    for (final element in map.objects.entries) {
      final sprite = sprites[getSpriteNameFromMapElement(element)];

      print(sprite);

      if (sprite != null) {
        continue;
      }

      final future = add(
        SpriteComponent(
          sprite: sprite,
          position: Vector2(
            element.key.x * MiniSpriteLibrary.defaultSpriteSize,
            element.key.y * MiniSpriteLibrary.defaultSpriteSize,
          ),
          size: Vector2(
            sprite!.image.width.toDouble(),
            sprite.image.height.toDouble(),
          ),
        ),
      );

      if (future != null) {
        componentLoadingFutures.add(future);
      }
    }

    await Future.wait(componentLoadingFutures);

    camera.zoom = 4;
  }

  // TODO(dev): later on, typing the map elements would be a better approach

  /// small method to avoid typos when accessing sprite entry in map elements
  String? getSpriteNameFromMapElement(MapEntry<MapPosition, Map<String, dynamic>> element) {
    return element.value['sprite'] as String?;
  }
}
