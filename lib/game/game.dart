import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/behaviors/gravity_rotator_behavior.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flamejam/game/components/player/player.dart';
import 'package:flutter/widgets.dart';

class FlameJam extends Forge2DGame with HasKeyboardHandlerComponents {
  /// Basic Game Component
  FlameJam() : super(gravity: Vector2(0, 10));

  late final CameraComponent rotatingCamera;

  @override
  Color backgroundColor() => const Color(0xFF0FF000);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final player = Player(position: Vector2(0, 20));

    final flamejamWorld = World();
    await add(flamejamWorld);

    final camera = CameraComponent(world: flamejamWorld);
    await add(camera);

    await flamejamWorld.addAll([
      GravityRotatorBehavior(),
      Box(),
      player,
      WallStatic(position: WallPosition.top),
      WallStatic(position: WallPosition.left),
      WallStatic(position: WallPosition.right),
      WallStatic(position: WallPosition.bottom),
    ]);

    // final camera = CameraComponent(world: flamejamWorld);
    // await add(camera);

    /* rotatingCamera =
        CameraComponent(world: flamejamWorld, viewport: CircularViewport(100));

    await rotatingCamera.viewport.addAll([
      GravityRotatorBehavior(),
      Box(),
      player,
      WallStatic(position: WallPosition.top),
      WallStatic(position: WallPosition.left),
      WallStatic(position: WallPosition.right),
      WallStatic(position: WallPosition.bottom),
    ]); */

    /* final world = World();

    await world.addAll([
      player,
      Box(),
      WallStatic(position: WallPosition.top),
      WallStatic(position: WallPosition.left),
      WallStatic(position: WallPosition.right),
      WallStatic(position: WallPosition.bottom),
    ]); */

    // camera.followBodyComponent(player);

    // camera.zoom = 5;
  }
}
