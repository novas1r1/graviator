import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

/// The GameCubit handles the state of the game.
/// Can be before the game starts, during the game, or after the game is over.
class GameCubit extends Cubit<GameState> {
  /// Constructs a GameCubit
  GameCubit() : super(const GameState());

  /// Starts the game
  void startGame() {
    emit(const GameState(status: GameStatus.gameScreenDisplayed));
  }

  /// Ends the game
  void endGame({required bool victory}) {
    emit(GameState(status: GameStatus.gameOverScreenDisplayed, hasWon: victory));
  }
}
