// ignore_for_file: public_member_api_docs

import 'package:flame/game.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isGameStarted = false;

  @override
  Widget build(BuildContext context) {
    return _isGameStarted
        ? const GameWidget.controlled(
            gameFactory: FlameJam.new,
          )
        : StartScreen(
            onStartGame: () => setState(() {
              _isGameStarted = true;
            }),
          );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.onStartGame});

  final VoidCallback onStartGame;

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
                    onPressed: onStartGame,
                    child: const Text(
                      'START dadwada',
                      style: TextStyle(fontFamily: 'BitPotion'),
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
