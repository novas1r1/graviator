// ignore_for_file: public_member_api_docs

import 'package:flame/game.dart';
import 'package:flamejam/app/cubits/game_cubit.dart';
import 'package:flamejam/game/game.dart';
import 'package:flamejam/game/screens/game_over_screen.dart';
import 'package:flamejam/game/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        switch (state.status) {
          case GameStatus.startScreenDisplayed:
            return const StartScreen();
          case GameStatus.gameScreenDisplayed:
            return const GameWidget.controlled(
              gameFactory: FlameJam.new,
            );
          case GameStatus.gameOverScreenDisplayed:
            return const GameOverScreen();
        }
      },
    );
  }
}
