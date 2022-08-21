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
    switch (health) {
      case 0:
        return Row(
          children: const [
            _Heart(isFull: false),
            SizedBox(width: 8),
            _Heart(isFull: false),
            SizedBox(width: 8),
            _Heart(isFull: false),
          ],
        );
      case 1:
        return Row(
          children: const [
            _Heart(isFull: true),
            SizedBox(width: 8),
            _Heart(isFull: false),
            SizedBox(width: 8),
            _Heart(isFull: false),
          ],
        );
      case 2:
        return Row(
          children: const [
            _Heart(isFull: true),
            SizedBox(width: 8),
            _Heart(isFull: true),
            SizedBox(width: 8),
            _Heart(isFull: false),
          ],
        );
      default:
        return Row(
          children: const [
            _Heart(isFull: true),
            SizedBox(width: 8),
            _Heart(isFull: true),
            SizedBox(width: 8),
            _Heart(isFull: true),
          ],
        );
    }
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
