// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/behaviors/camera_rotator_behavior.dart';
import 'package:flamejam/game/behaviors/gravity_rotator_behavior.dart';
import 'package:flamejam/game/components/ingame_ui/ingame_ui.dart';
import 'package:flamejam/game/game.dart';
import 'package:flamejam/main.dart';
import 'package:flamejam/message_box/cubit/message_box_cubit.dart';
import 'package:flutter/material.dart';
import 'package:game_audios/game_audios.dart';
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
    required String mapToLoad,
    required MessageBoxCubit messageBoxCubit,
  })  : _gameCubit = gameCubit,
        _astronautCubit = astronautCubit,
        _messageBoxCubit = messageBoxCubit,
        _mapToLoad = mapToLoad,
        super(
          gravity: Vector2(0, 10),
          zoom: 4,
        );

  final GameCubit _gameCubit;
  final AstronautCubit _astronautCubit;
  final MessageBoxCubit _messageBoxCubit;

  final String _mapToLoad;

  void Function(Canvas canvas) renderTreeCallback = (_) {};

  @override
  void renderTree(Canvas canvas) {
    renderTreeCallback(canvas);
    super.renderTree(canvas);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    if (_messageBoxCubit.state == const MessageBoxState.welcome()) {
      audioPlayer.play(FlameJamAudios.hello_pilot);
    }

    await MiniSpriteLibrary.loadSprites(
      pixelSize: 1,
      color: Colors.white,
    );

    overlays.add(IngameOverlay.flameOverlayId);

    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameCubit, GameState>.value(
            value: _gameCubit,
          ),
          FlameBlocProvider<AstronautCubit, AstronautState>.value(
            value: _astronautCubit,
          ),
          FlameBlocProvider<MessageBoxCubit, MessageBoxState>.value(
            value: _messageBoxCubit,
          ),
        ],
        children: [
          GameEntity(
            game: this,
            mapData: _mapToLoad,
            behaviors: [
              CameraRotatorBehavior(),
              GravityRotatorBehavior(),
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
    final map = MiniMap.fromDataString(mapData);
    await addAll(map.create());
  }
}
