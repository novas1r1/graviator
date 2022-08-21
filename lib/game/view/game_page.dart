// ignore_for_file: public_member_api_docs

import 'package:flame/game.dart';
import 'package:flamejam/game/components/ingame_ui/ingame_ui.dart';
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
        IngameOverlay.flameOverlayId: (_, __) => const IngameOverlay(),
      },
      gameFactory: () => FlameJam(
        gameCubit: context.read<GameCubit>(),
        astronautCubit: context.read<AstronautCubit>(),
      ),
    );
  }
}
