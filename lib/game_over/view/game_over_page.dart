// ignore_for_file: public_member_api_docs

import 'package:flamejam/game/bloc/game_cubit.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameOverPage extends StatelessWidget {
  const GameOverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(
                  child: Center(
                    child: Text(
                      'GAMEOVER',
                      style: TextStyle(fontSize: 72),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Expanded(
                  child: Center(
                    child: Text(
                      'SCORE: 0',
                      style: TextStyle(fontSize: 42),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 72),
            CallbackShortcuts(
              bindings: {
                const SingleActivator(LogicalKeyboardKey.space): () =>
                    context.read<GameCubit>().startGame(),
              },
              child: Focus(
                autofocus: true,
                child: GestureDetector(
                  onTap: () => context.read<GameCubit>().startGame(),
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('button_bg.png'),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'PLAY AGAIN',
                        style: TextStyle(fontSize: 42),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
