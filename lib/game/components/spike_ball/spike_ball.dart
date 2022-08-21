import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/bloc/game_cubit.dart';
import 'package:flamejam/game/components/astronaut/astronaut.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// A spiky ball that moves randomly on the map so that it could kill the astronaut
class SpikeBall extends BodyEntity {
  /// Creates an [SpikeBall]
  SpikeBall({required Vector2 initialPosition})
      : super(
          bodyComponent: _SpikeBall()..initialPosition = initialPosition,
        );

  /// Create a [SpikeBall] Entity from the [MiniMap] Entry
  SpikeBall.fromMapEntry({required MapEntry<MapPosition, Map<String, dynamic>> entry})
      : this(
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
        );
}

class _SpikeBall extends BodyComponent with InitialPosition, ContactCallbacks {
  _SpikeBall()
      : super(
          renderBody: false,
          children: [
            SpriteComponent(
              sprite: MiniSpriteLibrary.sprites['spike_ball'],
              size: Vector2.all(_spriteSize),
              position: Vector2(_spriteSize / -2, _spriteSize / -2),
            )
          ],
        );

  static const double _spriteSize = 16;

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Astronaut) readBloc<GameCubit, GameState>().loseGame();
    super.beginContact(other, contact);
  }

  @override
  Body createBody() {
    final fixtureDef = FixtureDef(
      PolygonShape()
        ..setAsBoxXY(
          (_spriteSize / 2) * 0.75,
          (_spriteSize / 2) * 0.75,
        ),
    );

    final bodyDef = BodyDef(
      userData: this,
      position: initialPosition,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
