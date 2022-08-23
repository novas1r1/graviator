// ignore_for_file: public_member_api_docs

part of 'astronaut_cubit.dart';

enum AstronautStatus {
  alive,
  dead,
}

@immutable
class AstronautState {
  const AstronautState({
    this.oxygen = GameConfig.maxOxygen,
    this.health = GameConfig.maxHealth,
    this.astronautStatus = AstronautStatus.alive,
    this.inventoryItems = const {},
  });

  final int oxygen;
  final int health;
  final AstronautStatus astronautStatus;
  final Set<InventoryItemType> inventoryItems;

  AstronautState copyWith({
    int? oxygen,
    int? health,
    AstronautStatus? astronautStatus,
    Set<InventoryItemType>? inventoryItems,
  }) {
    return AstronautState(
      oxygen: oxygen ?? this.oxygen,
      health: health ?? this.health,
      astronautStatus: astronautStatus ?? this.astronautStatus,
      inventoryItems: inventoryItems ?? this.inventoryItems,
    );
  }
}
