part of 'inventory_cubit.dart';

class InventoryState extends Equatable {
  const InventoryState({
    this.collectedItems = const {},
    this.isInventoryFull = false,
  });
  final Set<InventoryItemType> collectedItems;
  final bool isInventoryFull;

  @override
  List<Object> get props => [collectedItems, isInventoryFull];

  InventoryState copyWith({
    Set<InventoryItemType>? collectedItems,
    bool? isInventoryFull,
  }) {
    return InventoryState(
      collectedItems: collectedItems ?? this.collectedItems,
      isInventoryFull: isInventoryFull ?? this.isInventoryFull,
    );
  }
}
