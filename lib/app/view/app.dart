// ignore_for_file: public_member_api_docs

import 'package:flame/game.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter/widgets.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GameWidget.controlled(
      gameFactory: FlameJam.new,
    );
  }
}
