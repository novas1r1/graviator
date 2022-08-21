import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/game.dart';

class AstronautFollowerBehavior extends Behavior<Astronaut>
    with HasGameRef<Forge2DGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    gameRef.camera.followBodyComponent(parent.bodyComponent);
  }
}
