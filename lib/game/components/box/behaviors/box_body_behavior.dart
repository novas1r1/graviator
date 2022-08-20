import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/components/box/box.dart';

/// {@template game.components.box.behaviors.BoxBodyBehavior}
/// Adds a [Body] to the [Box].
///
/// A [Body] is a physical representation of the [Box]. Which allows it
/// to interact with the [World].
/// {@endtemplate}
class BoxBodyBehavior extends Behavior<Box> {
  /// {@macro game.components.box.behaviors.BoxBodyBehavior}
  BoxBodyBehavior() : super(children: [_BoxBodyComponent()]);
}

class _BoxBodyComponent extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: gameRef.size / 4,
    );

    return world.createBody(bodyDef)
      ..createFixtureFromShape(
        PolygonShape()..setAsBoxXY(10, 10),
      );
  }
}
