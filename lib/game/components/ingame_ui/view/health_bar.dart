import 'package:flamejam/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class HealthBar extends StatelessWidget {
  const HealthBar({
    super.key,
    required this.health,
  });

  final int health;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (health >= 1)
          const _Heart(isFull: true)
        else
          const _Heart(isFull: false),
        const SizedBox(width: 8),
        if (health >= 2)
          const _Heart(isFull: true)
        else
          const _Heart(isFull: false),
        const SizedBox(width: 8),
        if (health >= 3)
          const _Heart(isFull: true)
        else
          const _Heart(isFull: false),
      ],
    );
  }
}

class _Heart extends StatelessWidget {
  const _Heart({
    required this.isFull,
  });

  final bool isFull;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: isFull
          ? Image.asset(Assets.ingame.heartFull.path)
          : Image.asset(Assets.ingame.heartEmpty.path),
    );
  }
}
