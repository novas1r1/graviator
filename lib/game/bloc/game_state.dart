// ignore_for_file: public_member_api_docs

part of 'game_cubit.dart';

enum GameStatus {
  startScreenDisplayed,
  gameScreenDisplayed,
  gameOverScreenDisplayed,
}

@immutable
class GameState {
  const GameState({
    this.status = GameStatus.startScreenDisplayed,
    this.hasWon = true,
    this.score = 0,
    this.oxygenLeft = 0,
  });

  final GameStatus status;

  /// Whether the player has won the game or died
  final bool hasWon;
  final int score;
  final int oxygenLeft;
}
