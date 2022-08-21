// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'playert_state.dart';

class PlayerCubit extends Cubit<PlayertState> {
  PlayerCubit() : super(const PlayertState());

  void pickUpOxygen(int value) {
    emit(state.copyWith(oxygen: state.oxygen + value));
  }

  void reduceOxygen(int value) {
    emit(state.copyWith(oxygen: state.oxygen - value));
  }

  void die() {
    emit(
      state.copyWith(playerStatus: PlayerStatus.dead, health: 0, oxygen: 0),
    );
  }

  void revive() {
    emit(
      state.copyWith(
        playerStatus: PlayerStatus.alive,
        health: 100,
        oxygen: 100,
      ),
    );
  }

  /// Player dies if health drops below 0 after  taking [damage]
  void takeDamage(int damage) {
    final currentHealth = state.health - damage;

    if (currentHealth <= 0) {
      die();
    } else {
      emit(state.copyWith(health: currentHealth));
    }
  }
}
