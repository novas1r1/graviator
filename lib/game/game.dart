import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/behaviors/behaviors.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flutter/widgets.dart';

class FlameJam extends Forge2DGame with HasKeyboardHandlerComponents {
  FlameJam() : super(gravity: Vector2(0, 10));

  @override
  Color backgroundColor() => const Color(0xFF0FF000);

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
  }
}
