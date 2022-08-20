part of 'game_cubit.dart';

enum GameStatus {
  startScreenDisplayed,
  gameScreenDisplayed,
  gameOverScreenDisplayed,
}

@immutable
class GameState {
  const GameState({this.status = GameStatus.startScreenDisplayed});

  final GameStatus status;
}
