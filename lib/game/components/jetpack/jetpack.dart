import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flamejam/game/components/components.dart';

/// {@template game.components.jetpack.Jetpack}
/// Backpack that allows a player to propulse through space.
/// {@endtemplate}
class Jetpack extends Entity with ParentIsA<AstronautBodyComponent> {
  /// {@macro game.components.jetpack.Jetpack}
  Jetpack({super.behaviors});
}
