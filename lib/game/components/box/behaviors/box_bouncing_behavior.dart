import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/components/box/box.dart';

/// Makes the [Box] bounce when not moving.
class BoxBouncingBehavior extends Behavior<Box> {
  @override
  Future<void> update(double dt) async {
    super.update(dt);

    assert(
      parent.body.bodyType == BodyType.dynamic,
      'BoxBouncingBehavior only works with dynamic bodies',
    );

    final bouncingComponent = children.whereType<_BouncingComponent>();
    final hasBouncingComponent = bouncingComponent.isNotEmpty;
    if (!hasBouncingComponent) {
      await add(_BouncingComponent(body: parent.body));
    }
  }
}

class _BouncingComponent extends TimerComponent {
  _BouncingComponent({
    required this.body,
  }) : super(
          period: 1.5,
          removeOnFinish: true,
        );

  final Body body;

  @override
  void onTick() {
    super.onTick();
    final notMoving = body.linearVelocity.isZero();
    // TODO(paul): Make the box bounce depending on the mass.
    if (notMoving) body.applyLinearImpulse(Vector2(0, -20));
  }
}
