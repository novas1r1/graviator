import 'package:flamejam/game/components/components.dart';
import 'package:flamejam/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class InventoryWidget extends StatelessWidget {
  const InventoryWidget({
    super.key,
    required this.inventoryItems,
  });

  final Set<InventoryItemType> inventoryItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 98,
      height: 36,
      child: Stack(
        children: [
          Image.asset(Assets.ingame.inventory.path),
          Positioned(
            top: 8,
            left: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                inventoryItems.length,
                (index) => SizedBox(
                  width: 32,
                  height: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _getByIndex(inventoryItems.elementAt(index)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Image _getByIndex(InventoryItemType type) {
    switch (type) {
      case InventoryItemType.spaceshipWrench:
        return Image.asset(Assets.ingame.spaceshipWrench.path);
      case InventoryItemType.spaceshipFuelTank:
        return Image.asset(Assets.ingame.spaceshipFuel.path);
      case InventoryItemType.spaceshipComputer:
        return Image.asset(Assets.ingame.spaceshipComputer.path);
    }
  }
}
