import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flamejam/assets/assets.dart';
import 'package:flamejam/game/components/components.dart';
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
    audioPlayer.play(FlameJamAudios.background_loop);

    emit(
      state.copyWith(
        status: GameStatus.gameScreenDisplayed,
        currentGameLevel: 1,
      ),
    );
  }

  /// Ends the game
  void endGame({
    required bool victory,
    required Set<InventoryItemType> inventoryItems,
    required int oxygenLeft,
    required int healthLeft,
  }) {
    var score = 0;

    if (inventoryItems.contains(InventoryItemType.spaceshipWrench)) {
      score += 100;
    }

    if (inventoryItems.contains(InventoryItemType.spaceshipComputer)) {
      score *= 250;
    }

    if (inventoryItems.contains(InventoryItemType.spaceshipFuelTank)) {
      score *= 500;
    }

    if (oxygenLeft > 0) {
      score *= oxygenLeft;
    }

    if (healthLeft > 0) {
      score *= healthLeft;
    }

    emit(
      state.copyWith(
        status: GameStatus.gameOverScreenDisplayed,
        hasWon: victory,
        score: score,
      ),
    );
  }

  void nextLevel({
    required Set<InventoryItemType> inventoryItems,
    required int oxygenLeft,
    required int healthLeft,
  }) {
    if (state.currentGameLevel >= minGameLevel &&
        state.currentGameLevel < maxGameLevel) {
      final updatedLevel = state.currentGameLevel + 1;

      if (state.currentGameLevel == updatedLevel) return;

      emit(
        state.copyWith(
          status: GameStatus.gameScreenDisplayed,
          currentGameLevel: updatedLevel,
        ),
      );
    } else {
      endGame(
        victory: true,
        healthLeft: healthLeft,
        oxygenLeft: oxygenLeft,
        inventoryItems: inventoryItems,
      );
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
}
