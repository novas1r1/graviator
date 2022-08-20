import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/assets/assets.dart';

export 'building_block_dynamic.dart';
export 'building_block_factory.dart';
export 'building_block_static.dart';

/// building block
abstract class BuildingBlock {
  /// constructor
  BuildingBlock({
    required double positionX,
    required double positionY,
    required this.spriteName,
    BodyType bodyType = BodyType.static,
  })  : position = Vector2(
          width * positionX,
          height * positionY,
        ),
        body = BuildingBlockBody(
          bodyType: bodyType,
          position: Vector2(
            positionX * width + width / 2,
            positionY * height + height / 2,
          ),
        ) {
    final spriteData = MiniSpriteLibrary.sprites[spriteName];

    assert(spriteData != null, 'No sprite with the name $spriteName');

    sprite = SpriteComponent(
      sprite: spriteData,
      position: Vector2(width / 2, height / 2)..negate(),
      size: Vector2(
        spriteData!.image.width.toDouble(),
        spriteData.image.height.toDouble(),
      ),
    );

    body.add(sprite);
  }

  /// the name of the sprite to load
  final String spriteName;

  /// position
  final Vector2 position;

  /// default height
  static const double height = 16;

  /// default width
  static const double width = 16;

  /// physics body
  final BuildingBlockBody body;

  /// sprite
  late final SpriteComponent sprite;
}

/// physics for [BuildingBlock]
class BuildingBlockBody extends BodyComponent {
  /// building block constructor
  BuildingBlockBody({
    required this.position,
    this.bodyType = BodyType.static,
  });

  /// the position
  final Vector2 position;

  /// body type
  final BodyType bodyType;

  @override
  Body createBody() {
    final fixture = FixtureDef(
      PolygonShape()
        ..setAsBoxXY(
          BuildingBlock.width / 2 - 0.01,
          BuildingBlock.height / 2 - 0.01,
        ),
    );

    final body = BodyDef(
      position: position,
      userData: this,
      type: bodyType,
    );

    final worldBody = world.createBody(body)..createFixture(fixture);

    // paint.color = Colors.transparent;

    return worldBody;
  }
}
