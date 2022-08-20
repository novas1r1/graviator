import 'package:bloc/bloc.dart';

/// The [OxygenTank] cubit contains all information about the level of oxygen the player still has.
/// It is possible to inflate and deflate the Oxygen in the game with tanks
class OxygenTank extends Cubit<int> {
  /// Creates the cubit
  OxygenTank(super.initialState);

  /// Increase the current amount of the oxygen tank
  void inflated(int value) {
    emit(state + value);
  }

  /// Reduce the current amount of the oxygen tank
  void deflated(int value) {
    emit(state - value);
  }
}
