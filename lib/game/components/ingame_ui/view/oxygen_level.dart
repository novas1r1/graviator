// ignore_for_file: public_member_api_docs

import 'package:flamejam/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class OxygenLevel extends StatelessWidget {
  const OxygenLevel({
    super.key,
    required this.oxygen,
  });

  final int oxygen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 32,
          height: 32,
          child: Image.asset(Assets.ingame.oxygenLevel.path),
        ),
        const SizedBox(width: 16),
        Text(
          '$oxygen',
          style: const TextStyle(
            fontSize: 62,
            color: Colors.white,
            fontFamily: 'BitPotion',
          ),
        ),
      ],
    );
  }
}
