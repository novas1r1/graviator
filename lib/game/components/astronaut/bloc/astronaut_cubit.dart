// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:flamejam/game/components/components.dart';
import 'package:flamejam/main.dart';
import 'package:game_audios/game_audios.dart';
import 'package:meta/meta.dart';

part 'astronaut_state.dart';

const oxygenPerTank = 10;
const oxygenPerUsage = 1;
const maxOxygen = 1000;
const maxHealth = 3;

class AstronautCubit extends Cubit<AstronautState> {
  AstronautCubit() : super(const AstronautState());

  void pickUpOxygen() {
    audioPlayer.play(FlameJamAudios.plop);

    final currentOxygen = state.oxygen + oxygenPerTank;

    if (currentOxygen >= maxOxygen) {
      emit(state.copyWith(oxygen: maxOxygen));
    } else {
      emit(state.copyWith(oxygen: currentOxygen));
    }
  }

  void reduceOxygen() {
    final currentOxygen = state.oxygen - oxygenPerUsage;

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
        health: maxHealth,
        oxygen: maxOxygen,
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
