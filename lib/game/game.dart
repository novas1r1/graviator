// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/behaviors/gravity_rotator_behavior.dart';
import 'package:flamejam/game/components/components.dart';
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

  @override
  Color backgroundColor() => const Color.fromARGB(255, 0, 88, 255);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await MiniSpriteLibrary.loadSprites(pixelSize: 1, color: Colors.amber);

    await add(
      GameEntity(
        game: this,
        mapData: MiniSpriteMap.demoLevel,
        behaviors: [
          GravityRotatorBehavior(),
        ],
      ),
    );
  }
}

class GameEntity extends Entity {
  GameEntity({
    required this.mapData,
    required this.game,
    super.behaviors,
  });

  final String mapData;

  final FlameJam game;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final map = MiniMap.fromDataString(mapData);

    await addAll(Box.createAllFromMap(map.objects));
  }
}
