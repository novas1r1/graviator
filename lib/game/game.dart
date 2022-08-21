// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/behaviors/camera_rotator_behavior.dart';
import 'package:flamejam/game/behaviors/gravity_rotator_behavior.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter/material.dart';
import 'package:mini_sprite/mini_sprite.dart';

export 'bloc/bloc.dart';
export 'components/components.dart';
export 'view/view.dart';

/// the main game class
class FlameJam extends Forge2DGame with HasKeyboardHandlerComponents {
  /// default constructor
  FlameJam({
    required GameCubit gameCubit,
    required AstronautCubit astronautCubit,
  })  : _gameCubit = gameCubit,
        _astronautCubit = astronautCubit,
        super(
          gravity: Vector2(0, 10),
          zoom: 4,
        );

  final GameCubit _gameCubit;
  final AstronautCubit _astronautCubit;

  void Function(Canvas canvas) renderTreeCallback = (_) {};

  @override
  void renderTree(Canvas canvas) {
    renderTreeCallback(canvas);
    super.renderTree(canvas);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await MiniSpriteLibrary.loadSprites(
      pixelSize: 1,
      color: Colors.white,
    );

    const ingameOverlayIdentifier = 'IngameOverlay';

    overlays.add(ingameOverlayIdentifier);

    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameCubit, GameState>.value(
            value: _gameCubit,
          ),
          FlameBlocProvider<AstronautCubit, AstronautState>.value(
            value: _astronautCubit,
          ),
        ],
        children: [
          GameEntity(
            game: this,
            mapData: MiniSpriteMap.demoLevel,
            behaviors: [
              GravityRotatorBehavior(),
              CameraRotatorBehavior(),
            ],
          ),
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
    super.children,
  });

  final String mapData;

  final FlameJam game;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final children = <Component>[];
    final map = MiniMap.fromDataString(mapData);
    children.addAll(map.create());

    final astronaut = Astronaut(
      initialPosition: Vector2(16, 16),
      children: [
        Jetpack(
          behaviors: [JetpackPropulsingBehavior()],
        ),
      ],
      behaviors: [
        ControlledMovementBehavior(),
      ],
    );
    await addAll(children..add(astronaut));
    game.camera.followBodyComponent(astronaut.bodyComponent);
  }
}
