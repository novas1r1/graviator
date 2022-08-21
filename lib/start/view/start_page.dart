// ignore_for_file: public_member_api_docs

import 'package:flamejam/consts.dart';
import 'package:flamejam/game/game.dart';
import 'package:flamejam/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _defaultFontStyle = TextStyle(fontSize: 42);

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Name'.toUpperCase(),
              style: const TextStyle(fontSize: 60),
            ),
            SizedBox(height: Spacers.l * 3),
            Row(
              children: [
                Expanded(
                  child: CallbackShortcuts(
                    bindings: {
                      const SingleActivator(LogicalKeyboardKey.enter): () =>
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
                              'START GAME',
                              style: _defaultFontStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
