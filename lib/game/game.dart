// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/behaviors/camera_rotator_behavior.dart';
import 'package:flamejam/game/behaviors/gravity_rotator_behavior.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flamejam/game/components/player/behaviors/behaviors.dart';
import 'package:flutter/material.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// the main game class
class FlameJam extends Forge2DGame with HasKeyboardHandlerComponents {
  /// default constructor
  FlameJam()
      : super(
          gravity: Vector2(0, 10),
          zoom: 4,
        );

  void Function(Canvas canvas) renderTreeCallback = (_) {};

  @override
  void renderTree(Canvas canvas) {
    renderTreeCallback(canvas);
    super.renderTree(canvas);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await MiniSpriteLibrary.loadSprites(pixelSize: 1, color: Colors.white);

    await add(
      GameEntity(
        game: this,
        mapData: MiniSpriteMap.demoLevel,
        behaviors: [
          GravityRotatorBehavior(),
          CameraRotatorBehavior(),
        ],
        children: [],
      ),
    );
  }

  // TODO(dev): later on, typing the map elements would be a better approach
  /// small method to avoid typos when accessing sprite entry in map elements
  static String? getSpriteNameFromMapElement(
    MapEntry<MapPosition, Map<String, dynamic>> element,
  ) {
    return element.value['sprite'] as String?;
  }
}

class GameEntity extends Entity {
  GameEntity({
    required this.mapData,
    required this.game,
    super.behaviors,
    super.children,
  });

  final String mapData;

  final FlameJam game;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final children = <Component>[];
    final map = MiniMap.fromDataString(mapData);
    for (final element in map.objects.entries) {
      children.addAll(BuildingBlockFactory.resolveMapEntry(element));
    }

    final player = Player(
      initialPosition: Vector2(16, 16),
      behaviors: [
        ControlledMovementBehavior(),
      ],
    );
    await addAll(children..add(player));
    game.camera.followBodyComponent(player.bodyComponent);
  }
}
