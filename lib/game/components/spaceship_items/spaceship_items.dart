import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/mini_sprite_library.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flamejam/game/components/ingame_ui/inventory.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// The [SpaceshipItem] can be collected.
class SpaceshipItem extends BodyEntity {
  /// Creates a [SpaceshipItem] instance
  SpaceshipItem({
    required InventoryItemType itemType,
    required Vector2 initialPosition,
  }) : super(
          bodyComponent: _SpaceshipItemComponent(itemType: itemType)
            ..initialPosition = initialPosition,
          behaviors: [],
        );

  /// Create a [SpaceshipItem] Entity from the [MiniMap] Entry
  SpaceshipItem.fromMapEntry({
    required MapEntry<MapPosition, Map<String, dynamic>> entry,
    required InventoryItemType itemType,
  }) : this(
          itemType: itemType,
          initialPosition: Vector2(
            entry.key.x.toDouble() * 16,
            entry.key.y.toDouble() * 16,
          ),
        );
}

class _SpaceshipItemComponent extends BodyComponent
    with InitialPosition, ContactCallbacks {
  _SpaceshipItemComponent({
    required this.itemType,
  }) : super(
          renderBody: false,
          children: [
            SpriteComponent(
              size: _spriteSize,
              sprite: _getSpriteForItemType(itemType),
              anchor: Anchor.center,
              position: Vector2(_spriteSize.x * 0.005, 0),
              priority: 0,
            )
          ],
        );
  final InventoryItemType itemType;

  static final _spriteSize = Vector2.all(12);

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if (other is Astronaut) {
      readBloc<AstronautCubit, AstronautState>().pickupItem(itemType);
      parent!.removeFromParent();
    }
  }

  @override
  Body createBody() {
    paint.color = const Color(0xffff00000);
    final fixtureDef = FixtureDef(
      CircleShape()..radius = _spriteSize.x / 2,
      restitution: 0.4,
    );
    return world.createBody(
      BodyDef(
        type: BodyType.dynamic,
        position: initialPosition,
        userData: this,
      ),
    )..createFixture(fixtureDef);
  }

  static Sprite? _getSpriteForItemType(InventoryItemType itemType) {
    switch (itemType) {
      case InventoryItemType.spaceshipWrench:
        return MiniSpriteLibrary.sprites['spaceship_wrench'];
      case InventoryItemType.spaceshipFuelTank:
        return MiniSpriteLibrary.sprites['spaceship_tank'];
      case InventoryItemType.spaceshipComputer:
        return MiniSpriteLibrary.sprites['spaceship_computer'];
    }
  }
}
