import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState());

  void startGame() {
    emit(const GameState(status: GameStatus.gameScreenDisplayed));
  }

  void endGame() {
    emit(const GameState(status: GameStatus.gameOverScreenDisplayed));
  }
}
