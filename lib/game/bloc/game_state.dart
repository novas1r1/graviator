// ignore_for_file: public_member_api_docs

part of 'game_cubit.dart';

enum GameStatus {
  startScreenDisplayed,
  gameScreenDisplayed,
  gameOverScreenDisplayed,
}

@immutable
class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.startScreenDisplayed,
    this.currentGameLevel = minGameLevel,
    this.hasWon = true,
    this.score = 0,
    this.oxygenLeft = 0,
  });

  final GameStatus status;

  /// Whether the player has won the game or died
  final bool hasWon;
  final int score;
  final int oxygenLeft;
  final int currentGameLevel;

  GameState copyWith({
    GameStatus? status,
    bool? hasWon,
    int? score,
    int? oxygenLeft,
    int? currentGameLevel,
  }) {
    return GameState(
      status: status ?? this.status,
      hasWon: hasWon ?? this.hasWon,
      score: score ?? this.score,
      oxygenLeft: oxygenLeft ?? this.oxygenLeft,
      currentGameLevel: currentGameLevel ?? this.currentGameLevel,
    );
  }

  @override
  List<Object> get props {
    return [
      status,
      hasWon,
      score,
      oxygenLeft,
      currentGameLevel,
    ];
  }
}

extension GameLevelMap on int {
  String getSpriteMap() {
    if (this == 1) {
      return MiniSpriteMap.firstLevel;
    } else if (this == 2) {
      return MiniSpriteMap.secondLevel;
    } else {
      throw Exception('Invalid game level');
    }
  }
}
