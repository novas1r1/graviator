// ignore_for_file: public_member_api_docs

import 'package:flamejam/game/components/ingame_ui/ingame_ui.dart';
import 'package:flutter/material.dart';

class IngameOverlay extends StatelessWidget {
  const IngameOverlay({
    super.key,
    required this.health,
    required this.oxygen,
  });

  static const flameOverlayId = 'flame-overlay__status_bar';

  final int health;
  final int oxygen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HealthBar(health: health),
          OxygenLevel(oxygen: oxygen),
        ],
      ),
    );
  }
}
