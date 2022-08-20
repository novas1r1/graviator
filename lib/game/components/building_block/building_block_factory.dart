import 'package:flame/components.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// creates building blocks from map entries
class BuildingBlockFactory {
  BuildingBlockFactory._();

  /// takes a map entry and returns a list of all components that could be generated
  static List<Component> resolveMapEntry(MapEntry<MapPosition, Map<String, dynamic>> entry) {
    final spriteName = getSpriteNameFromMapElement(entry);

    switch (spriteName) {
      // TODO(dev): rename
      case 'building_block':
        final block = BuildingBlockStatic(
          positionX: entry.key.x.toDouble(),
          positionY: entry.key.y.toDouble(),
        );

        return [block.body];
      case 'building_block_dynamic':
        final block = BuildingBlockDynamic(
          positionX: entry.key.x.toDouble(),
          positionY: entry.key.y.toDouble(),
        );

        return [block.body];
      default:
        return [];
    }
  }

  /// small method to avoid typos when accessing sprite entry in map elements
  static String? getSpriteNameFromMapElement(MapEntry<MapPosition, Map<String, dynamic>> element) {
    return element.value['sprite'] as String?;
  }
}
