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
}
