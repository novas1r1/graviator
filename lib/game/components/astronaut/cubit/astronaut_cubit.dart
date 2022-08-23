// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flamejam/game/helpers/helpers.dart';
import 'package:flamejam/main.dart';
import 'package:game_audios/game_audios.dart';
import 'package:meta/meta.dart';

part 'astronaut_state.dart';

class AstronautCubit extends Cubit<AstronautState> {
  AstronautCubit() : super(const AstronautState());

  void pickUpOxygen() {
    audioPlayer.play(FlameJamAudios.plop);

    final currentOxygen = state.oxygen + GameConfig.oxygenPerTank;

    if (currentOxygen >= GameConfig.maxOxygen) {
      emit(state.copyWith(oxygen: GameConfig.maxOxygen));
    } else {
      emit(state.copyWith(oxygen: currentOxygen));
    }
  }

  void reduceOxygen() {
    final currentOxygen = state.oxygen - GameConfig.oxygenPerUsage;

    if (currentOxygen <= 0) {
      die();
    } else {
      emit(state.copyWith(oxygen: currentOxygen));
    }
  }

  void die() {
    emit(
      state.copyWith(
        astronautStatus: AstronautStatus.dead,
        health: 0,
        oxygen: 0,
        inventoryItems: {},
      ),
    );
  }

  void revive() {
    emit(
      state.copyWith(
        astronautStatus: AstronautStatus.alive,
        health: GameConfig.maxHealth,
        oxygen: GameConfig.maxOxygen,
        inventoryItems: {},
      ),
    );
  }

  /// Player dies if health drops below 0 after  taking [damage]
  void takeDamage(int damage) {
    audioPlayer.play(FlameJamAudios.pain);

    final currentHealth = state.health - damage;

    if (currentHealth <= 0) {
      die();
    } else {
      emit(state.copyWith(health: currentHealth));
    }
  }

  void pickupItem(InventoryItemType item) {
    final updatedInventory = state.inventoryItems.toSet()..add(item);

    emit(
      state.copyWith(
        inventoryItems: updatedInventory,
      ),
    );
  }
}
