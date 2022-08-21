// ignore_for_file: public_member_api_docs

import 'package:flame/game.dart';
import 'package:flamejam/game/game.dart';
import 'package:flamejam/game/view/message_box.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget.controlled(
      initialActiveOverlays: const [
        MessageBox.flameOverlayId,
      ],
      overlayBuilderMap: {
        MessageBox.flameOverlayId: (_, __) => const MessageBox(
              text: 'Hello world',
            ),
      },
      gameFactory: () => FlameJam(
        gameCubit: context.read<GameCubit>(),
        astronautCubit: context.read<AstronautCubit>(),
      ),
    );
  }
}
