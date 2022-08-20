import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flamejam/game/components/components.dart';

/// {@}
/// Backpack that allows a player to propulse through space.
class Jetpack extends Entity with ParentIsA<AstronautBodyComponent> {
  Jetpack({super.behaviors});
}
