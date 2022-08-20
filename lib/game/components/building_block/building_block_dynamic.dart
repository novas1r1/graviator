import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/components/components.dart';

/// a dynamic building block
class BuildingBlockDynamic extends BuildingBlock {
  /// creates a dynamic building block
  BuildingBlockDynamic({
    required super.positionX,
    required super.positionY,
  }) : super(
          bodyType: BodyType.dynamic,
          spriteName: 'building_block_dynamic',
        );
}
