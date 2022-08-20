// ignore_for_file: public_member_api_docs

import 'package:flamejam/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.read<GameCubit>().startGame(),
                    child: const Text(
                      'START GAME',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
