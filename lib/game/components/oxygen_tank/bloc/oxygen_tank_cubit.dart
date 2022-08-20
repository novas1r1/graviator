import 'package:bloc/bloc.dart';

/// The [OxygenTankCubit] cubit contains all information about the level of oxygen the player still has.
/// It is possible to inflate and deflate the Oxygen in the game with tanks
class OxygenTankCubit extends Cubit<int> {
  /// Creates the cubit
  OxygenTankCubit(super.initialState);

  /// Increase the current amount of the oxygen tank
  void inflated(int value) {
    emit(state + value);
  }

  /// Reduce the current amount of the oxygen tank
  void deflated(int value) {
    emit(state - value);
  }
}
