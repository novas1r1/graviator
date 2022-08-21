// ignore_for_file: public_member_api_docs

import 'package:flame/game.dart';
import 'package:flamejam/game/components/astronaut/astronaut.dart';
import 'package:flamejam/game/game.dart';
import 'package:flamejam/game_over/game_over.dart';
import 'package:flamejam/start/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AstronautCubit, AstronautState>(
      listener: (context, state) {
        if (state.astronautStatus == AstronautStatus.dead) {
          context.read<GameCubit>().endGame();
        }
      },
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          switch (state.status) {
            case GameStatus.startScreenDisplayed:
              return const StartPage();
            case GameStatus.gameScreenDisplayed:
              return GameWidget.controlled(
                gameFactory: () => FlameJam(
                  gameCubit: context.read<GameCubit>(),
                  astronautCubit: context.read<AstronautCubit>(),
                ),
              );
            case GameStatus.gameOverScreenDisplayed:
              return GameOverPage(
                hasPlayerWon: state.hasWon,
                score: state.score,
              );
          }
        },
      ),
    );
  }
}
