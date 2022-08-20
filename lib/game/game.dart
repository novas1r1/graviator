import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/behaviors/gravity_rotator_behavior.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flamejam/game/components/player/player.dart';
import 'package:flutter/widgets.dart';

class FlameJam extends Forge2DGame
    with HasKeyboardHandlerComponents, HasTappableComponents {
  /// Basic Game Component
  FlameJam() : super(gravity: Vector2(0, 10));

  late final CameraComponent rotatingCamera;

  @override
  Color backgroundColor() => const Color(0xFF0FF000);

  // TODO rotation workaround, but how to trigger
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.rotate(1.5708);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // rotatingCamera = CameraComponent(
    //   world: world,
    //   viewport: FixedSizeViewport(200, 200),
    // )
    //   ..viewfinder.zoom = 5
    //   ..viewfinder.anchor = const Anchor(0.25, 0.75)
    //   ..viewfinder.angle = 1.5708;
/* 
    final world = World();
    final viewPort = FixedSizeViewport(200, 200);
    await viewPort.add(ViewportFrame());

    rotatingCamera = CameraComponent(
      world: world,
      viewport: viewPort,
    );
    
    rotatingCamera = CameraComponent(
      world: world,
      viewport: FixedSizeViewport(200, 200)await ..add(ViewportFrame()),
    ); */
/* 
    final player = Player(position: Vector2(0, 20));

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
    ]); */

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

    final player = Player(position: Vector2(0, 20));

    await addAll([
      player,
      Box(),
      GravityRotatorBehavior(),
      WallStatic(position: WallPosition.top),
      WallStatic(position: WallPosition.left),
      WallStatic(position: WallPosition.right),
      WallStatic(position: WallPosition.bottom),
    ]);
  }
}
