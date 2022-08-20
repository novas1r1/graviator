import 'package:flame_test/flame_test.dart';
import 'package:flamejam/game/behaviors/behaviors.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(FlameJam, () {
    final flameTester = FlameTester(FlameJam.new);

    test('can be instantiated', () {
      expect(FlameJam(), isA<FlameJam>());
    });

    group('loads', () {
      flameTester.test('a single $GravityRotatorBehavior', (game) async {
        await game.ready();
        expect(
          game.descendants().whereType<GravityRotatorBehavior>().length,
          equals(1),
        );
      });
    });
  });
}
