import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/components/astronaut/astronaut.dart';
import 'package:flamejam/main.dart';
import 'package:flutter/material.dart';
import 'package:game_audios/game_audios.dart';

part 'game_state.dart';

const minGameLevel = 1;
const maxGameLevel = 3;

/// The GameCubit handles the state of the game.
/// Can be before the game starts, during the game, or after the game is over.
class GameCubit extends Cubit<GameState> {
  /// Constructs a GameCubit
  GameCubit() : super(const GameState.initial());

  /// Starts the game
  void startGame() {
    emit(
      state.copyWith(
        status: GameStatus.gameScreenDisplayed,
        currentGameLevel: 1,
      ),
    );
  }

  void nextLevel() {
    if (state.currentGameLevel >= minGameLevel &&
        state.currentGameLevel < maxGameLevel) {
      audioPlayer.play(FlameJamAudios.level_complete);

      final updatedLevel = state.currentGameLevel + 1;

      if (state.currentGameLevel == updatedLevel) return;

      emit(
        state.copyWith(
          status: GameStatus.gameScreenDisplayed,
          currentGameLevel: updatedLevel,
        ),
      );
    } else {
      endGame(victory: true);
    }
  }

  void previousLevel() {
    if (state.currentGameLevel > minGameLevel) {
      final updatedLevel = state.currentGameLevel - 1;

      emit(
        state.copyWith(
          status: GameStatus.gameScreenDisplayed,
          currentGameLevel: updatedLevel,
        ),
      );
    }
  }

  /// Ends the game
  void endGame({required bool victory}) {
    emit(
      state.copyWith(
        status: GameStatus.gameOverScreenDisplayed,
        hasWon: victory,
      ),
    );
  }
}
