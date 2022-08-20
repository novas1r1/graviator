// ignore_for_file: must_be_immutable

import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flamejam/game/behaviors/behaviors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _TestGame extends Forge2DGame with HasKeyboardHandlerComponents {}

class _MockRawKeyUpEvent extends Mock implements RawKeyUpEvent {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      super.toString();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(GravityRotatorBehavior, () {
    final flameTester = FlameTester(_TestGame.new);

    test('can be instantiated', () {
      expect(GravityRotatorBehavior(), isA<GravityRotatorBehavior>());
    });

    flameTester.test('can be added', (game) async {
      await game.ready();
      await game.ensureAdd(GravityRotatorBehavior());
      expect(
        game.descendants().whereType<GravityRotatorBehavior>().length,
        equals(1),
      );
    });

    group('onKeyEvent', () {
      flameTester.test(
        'changes gravity anti-clockwise when space is pressed',
        (game) async {
          await game.ready();
          final behavior = GravityRotatorBehavior();
          await game.ensureAdd(behavior);

          final event = _MockRawKeyUpEvent();
          when(() => event.logicalKey).thenReturn(
            LogicalKeyboardKey.space,
          );

          final gravity = game.world.gravity;

          expect(gravity, equals(Vector2(0, 10)));

          behavior.onKeyEvent(event, {});
          await Future<void>.delayed(Duration.zero);

          expect(gravity, equals(Vector2(-10, 0)));

          behavior.onKeyEvent(event, {});
          await Future<void>.delayed(Duration.zero);

          expect(gravity, equals(Vector2(0, -10)));

          behavior.onKeyEvent(event, {});
          await Future<void>.delayed(Duration.zero);

          expect(gravity, equals(Vector2(10, 0)));

          behavior.onKeyEvent(event, {});
          await Future<void>.delayed(Duration.zero);

          expect(gravity, equals(Vector2(0, 10)));
        },
      );
    });
  });
}
