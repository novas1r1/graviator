// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'astronaut_state.dart';

const oxygenPerTank = 10;
const oxygenPerUsage = 1;
const maxOxygen = 100;
const maxHealth = 3;

class AstronautCubit extends Cubit<AstronautState> {
  AstronautCubit() : super(const AstronautState());

  void pickUpOxygen() {
    final currentOxygen = state.oxygen + oxygenPerTank;

    if (currentOxygen >= maxOxygen) {
      emit(state.copyWith(oxygen: maxOxygen));
      print('PICKED UP OXYGEN, OXYGEN: $maxOxygen');
    } else {
      emit(state.copyWith(oxygen: currentOxygen));
      print('PICKED UP OXYGEN, OXYGEN: $currentOxygen');
    }
  }

  void reduceOxygen() {
    final currentOxygen = state.oxygen - oxygenPerUsage;

    print('OXYGEN REDUCED, OXYGEN: $currentOxygen');

    if (currentOxygen <= 0) {
      die();
    } else {
      emit(state.copyWith(oxygen: currentOxygen));
    }
  }

  void die() {
    print('PLAYER DIED');

    emit(
      state.copyWith(
        astronautStatus: AstronautStatus.dead,
        health: 0,
        oxygen: 0,
      ),
    );
  }

  void revive() {
    print('PLAYER BACK ALIVE');

    emit(
      state.copyWith(
        astronautStatus: AstronautStatus.alive,
        health: maxHealth,
        oxygen: maxOxygen,
      ),
    );
  }

  /// Player dies if health drops below 0 after  taking [damage]
  void takeDamage(int damage) {
    final currentHealth = state.health - damage;

    print('PLAYER TOOK DAMAGE, HEALTH: $currentHealth');

    if (currentHealth <= 0) {
      die();
    } else {
      emit(state.copyWith(health: currentHealth));
    }
  }
}
