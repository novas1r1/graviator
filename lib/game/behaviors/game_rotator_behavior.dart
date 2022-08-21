import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flamejam/game/behaviors/camera_rotator_behavior.dart';
import 'package:flamejam/game/behaviors/gravity_rotator_behavior.dart';
import 'package:flamejam/game/game.dart';

class RotatorBehavior extends Behavior<GameEntity> {
  void _onTick() {
    parent
      ..removeAll(
        [
          ...parent.children.whereType<CameraRotatorBehavior>(),
          ...parent.children.whereType<GravityRotatorBehavior>(),
        ],
      )
      ..addAll([
        CameraRotatorBehavior(),
        GravityRotatorBehavior(),
      ]);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(
      TimerComponent(
        period: 8,
        repeat: true,
        onTick: _onTick,
      ),
    );
  }
}
