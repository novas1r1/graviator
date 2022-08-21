// ignore_for_file: public_member_api_docs

import 'package:flamejam/consts.dart';
import 'package:flamejam/game/game.dart';
import 'package:flamejam/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const defaultFontStyle = TextStyle(fontSize: 42);

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
            const Text(
              'You are a Space Pirate and you wanted to grapple a unkonw space ship, but suddenly you got trapped and you found a useful gun to change the gravity! Your goal is to escape the space ship before it is too late!',
              style: defaultFontStyle,
            ),
            SizedBox(height: Spacers.m),
            Row(
              children: [
                Image.asset(
                  Assets.tutorial.astronaut.path,
                  width: 32,
                  height: 32,
                ),
                SizedBox(width: Spacers.m),
                const Expanded(child: Text('This is still you, stay alive!', style: defaultFontStyle))
              ],
            ),
            Row(
              children: [
                Image.asset(
                  Assets.tutorial.portal.path,
                  width: 32,
                  height: 32,
                ),
                SizedBox(width: Spacers.m),
                const Expanded(
                  child: Text(
                    'If you can reach it you you survived the alien vessel and are able to take the treasure back to your space pirate cave.',
                    style: defaultFontStyle,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      Assets.tutorial.oxygenTank.path,
                      width: 32,
                      height: 32,
                    ),
                    Image.asset(
                      Assets.tutorial.oxygenTankLabel.path,
                      width: 8,
                      height: 8,
                    )
                  ],
                ),
                SizedBox(width: Spacers.m),
                const Expanded(
                    child: Text(
                  'Air is quite important these days and if you run out you cannot fly anymore. Ah and breathing is also harder without it.',
                  style: defaultFontStyle,
                ))
              ],
            ),
            Row(
              children: [
                Image.asset(
                  Assets.tutorial.spikeBall.path,
                  width: 32,
                  height: 32,
                ),
                SizedBox(width: Spacers.m),
                const Expanded(
                  child: Text(
                    'You only live once, but this thing will shorten it quite fast, avoid it if possible.',
                    style: defaultFontStyle,
                  ),
                )
              ],
            ),
            SizedBox(height: Spacers.l * 3),
            Row(
              children: [
                Expanded(
                  child: CallbackShortcuts(
                    bindings: {
                      const SingleActivator(LogicalKeyboardKey.enter): () => context.read<GameCubit>().startGame(),
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
                              style: defaultFontStyle,
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
