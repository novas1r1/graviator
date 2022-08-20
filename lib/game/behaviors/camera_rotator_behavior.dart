import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter/services.dart';

/// {@template game.behaviors.CameraRotatorBehavior}
/// Rotates the camera clockwise when [_keys] are pressed.
/// {@endtemplate}
class CameraRotatorBehavior extends Behavior<GameEntity>
    with KeyboardHandler, HasGameRef<Forge2DGame> {
  /// {@macro game.behaviors.CameraRotatorBehavior}
  CameraRotatorBehavior();

  late final List<LogicalKeyboardKey> _keys = [LogicalKeyboardKey.space];

  double _rotation = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    parent.game.renderTreeCallback = _onGameRenderTree;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void _onGameRenderTree(ui.Canvas canvas) {
    final camera = parent.game.camera;
    final center = (gameRef.size / 2) * camera.zoom;

    canvas
      ..translate(center.x, center.y)
      ..rotate(_rotation)
      ..translate(-center.x, -center.y);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  bool onKeyEvent(RawKeyEvent event, _) {
    if (event is! RawKeyUpEvent) return true;
    if (!_keys.contains(event.logicalKey)) return true;

    if (children.whereType<_AnimationEffect>().isEmpty) {
      add(
        _AnimationEffect(
          a: _rotation,
          b: _rotation + math.pi / -2,
          onStep: (value) => _rotation = value,
        ),
      );
    }

    return true;
  }
}

class _AnimationEffect extends Effect {
  _AnimationEffect({
    required this.a,
    required this.b,
    required this.onStep,
  }) : super(
          EffectController(
            duration: 1,
          ),
        ) {
    removeOnFinish = true;
  }

  final double a;
  final double b;

  final void Function(double progress) onStep;

  @override
  void apply(double progress) {
    final lerp = ui.lerpDouble(a, b, progress) ?? b;
    onStep(lerp);
  }
}
