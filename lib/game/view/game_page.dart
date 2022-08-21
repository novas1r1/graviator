// ignore_for_file: public_member_api_docs

import 'package:flame/game.dart';
import 'package:flamejam/game/components/ingame_ui/ingame_ui.dart';
import 'package:flamejam/game/game.dart';
import 'package:flamejam/message_box/cubit/message_box_cubit.dart';
import 'package:flamejam/message_box/message_box.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
    required this.gameLevelMapToLoad,
  });

  final String gameLevelMapToLoad;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MessageBoxCubit>(
          create: (_) => MessageBoxCubit(),
        ),
      ],
      child: _GameView(gameLevelMapToLoad: gameLevelMapToLoad),
    );
  }
}

class _GameView extends StatefulWidget {
  const _GameView({
    required this.gameLevelMapToLoad,
  });

  final String gameLevelMapToLoad;

  @override
  State<_GameView> createState() => _GameViewState();
}

class _GameViewState extends State<_GameView> {
  late final FlameJam _game;

  @override
  void initState() {
    super.initState();
    _game = FlameJam(
      gameCubit: context.read<GameCubit>(),
      astronautCubit: context.read<AstronautCubit>(),
      messageBoxCubit: context.read<MessageBoxCubit>(),
      mapToLoad: widget.gameLevelMapToLoad,
    );
  }

  @override
  Widget build(BuildContext context) {
    final messageBloc = context.read<MessageBoxCubit>();

    return BlocListener<MessageBoxCubit, MessageBoxState>(
      listener: (_, __) => _game.overlays.add(MessageBox.flameOverlayId),
      child: GameWidget(
        initialActiveOverlays: const [
          MessageBox.flameOverlayId,
          IngameOverlay.flameOverlayId,
        ],
        overlayBuilderMap: {
          IngameOverlay.flameOverlayId: (_, __) => const IngameOverlay(),
          MessageBox.flameOverlayId: (_, Game game) {
            if (messageBloc.state.text.isEmpty) return const SizedBox.shrink();
            return MessageBox(
              text: messageBloc.state.text,
              duration: messageBloc.state.duration,
              onComplete: () => game.overlays.remove(MessageBox.flameOverlayId),
            );
          }
        },
        game: FlameJam(
          gameCubit: context.read<GameCubit>(),
          astronautCubit: context.read<AstronautCubit>(),
          messageBoxCubit: context.read<MessageBoxCubit>(),
          mapToLoad: widget.gameLevelMapToLoad,
        ),
      ),
    );
  }
}
