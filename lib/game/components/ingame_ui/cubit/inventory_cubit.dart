import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flamejam/game/components/ingame_ui/inventory.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit() : super(const InventoryState());

  void collectItem(InventoryItemType item) {
    final updatedInventory = state.collectedItems.toSet()..add(item);

    emit(
      state.copyWith(
        collectedItems: updatedInventory,
        isInventoryFull: updatedInventory.length == Inventory.maxItems,
      ),
    );
  }
}
