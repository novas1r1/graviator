// ignore_for_file: public_member_api_docs

import 'package:flamejam/game/components/astronaut/astronaut.dart';
import 'package:flamejam/game/components/ingame_ui/ingame_ui.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AstronautCubit, AstronautState>(
      listener: (context, state) {
        if (state.astronautStatus == AstronautStatus.dead) {
          context.read<GameCubit>().endGame(victory: false);
        }
      },
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return const MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.black,
              body: IngameOverlay(
                health: 3,
                oxygen: 100,
              ),
            ),
          );
          /* switch (state.status) {
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
          } */
        },
      ),
    );
  }
}
