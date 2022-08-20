import 'package:flame/game.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 1.5708,
      child: Container(
        color: Colors.black,
        child: const GameWidget.controlled(
          gameFactory: FlameJam.new,
        ),
      ),
    );

    // TODO check if possible workaround
    // return Transform.rotate(
    //   angle: 1.5708,
    //   child: Container(
    //     color: Colors.black,
    //     child: const GameWidget.controlled(
    //       gameFactory: FlameJam.new,
    //     ),
    //   ),
    // );
  }
}
