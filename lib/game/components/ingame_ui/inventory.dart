class Inventory {
  Inventory({required this.inventoryItems});

  final Set<InventoryItemType> inventoryItems;

  static const maxItems = 3;
  static const minItems = 0;
}

enum InventoryItemType {
  spaceshipWrench,
  spaceshipFuelTank,
  spaceshipComputer,
}
