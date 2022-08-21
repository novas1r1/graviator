// ignore_for_file: public_member_api_docs

import 'package:flamejam/game/components/components.dart';
import 'package:flamejam/game/components/ingame_ui/ingame_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IngameOverlay extends StatelessWidget {
  const IngameOverlay({
    super.key,
  });

  static const flameOverlayId = 'flame-overlay__status_bar';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocSelector<AstronautCubit, AstronautState, int>(
            selector: (state) => state.health,
            builder: (context, health) => HealthBar(health: health),
          ),
          BlocSelector<AstronautCubit, AstronautState, int>(
            selector: (state) => state.oxygen,
            builder: (context, oxygen) => OxygenLevel(oxygen: oxygen),
          ),
          BlocSelector<AstronautCubit, AstronautState, Set<InventoryItemType>>(
            selector: (state) => state.inventoryItems,
            builder: (context, inventoryItems) => InventoryWidget(
              inventoryItems: inventoryItems,
            ),
          ),
        ],
      ),
    );
  }
}
