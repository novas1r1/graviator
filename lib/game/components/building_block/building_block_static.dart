import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flamejam/game/components/components.dart';

/// static building block
class BuildingBlockStatic extends BuildingBlock {
  /// creates a static building block
  BuildingBlockStatic({
    required super.positionX,
    required super.positionY,
  }) : super(
          bodyType: BodyType.static,
          spriteName: 'building_block_static',
        );
}
