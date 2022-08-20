import 'package:mini_sprite/mini_sprite.dart';

/// holds the sprite data
class MiniSpriteLibrary {
  /// default sprite size
  static const double defaultSpriteSize = 16;

  /// static building block raw data
  static const buildingBlock =
      '''16,16;17,0;2,1;10,0;2,1;2,0;3,1;8,0;3,1;3,0;3,1;6,0;3,1;5,0;3,1;4,0;3,1;7,0;3,1;2,0;3,1;9,0;6,1;11,0;4,1;12,0;4,1;11,0;6,1;9,0;3,1;2,0;3,1;7,0;3,1;4,0;3,1;5,0;3,1;6,0;3,1;3,0;3,1;8,0;3,1;2,0;2,1;10,0;2,1;17,0''';

  /// dynamic building block raw data
  static const buildingBlockDynamic =
      '''16,16;17,0;2,1;6,0;1,1;3,0;2,1;2,0;3,1;2,0;1,1;5,0;3,1;3,0;3,1;6,0;3,1;5,0;3,1;4,0;3,1;7,0;3,1;2,0;3,1;5,0;1,1;3,0;6,1;3,0;1,1;3,0;1,1;3,0;4,1;7,0;1,1;4,0;4,1;3,0;1,1;3,0;1,1;3,0;6,1;2,0;1,1;3,0;1,1;2,0;3,1;2,0;3,1;2,0;1,1;4,0;3,1;4,0;3,1;5,0;3,1;3,0;1,1;2,0;3,1;3,0;3,1;2,0;2,1;4,0;3,1;2,0;2,1;4,0;1,1;1,0;1,1;3,0;2,1;17,0''';

  /// static building block sprite
  static final buildingBlockSprite = MiniSprite.fromDataString(buildingBlock);

  /// dynamic building block sprite
  static final buildingBlockDynamicSprite = MiniSprite.fromDataString(buildingBlockDynamic);

  /// mini sprite library
  static final library = MiniLibrary({
    'building_block': buildingBlockSprite,
    'building_block_dynamic': buildingBlockDynamicSprite,
  });
}
