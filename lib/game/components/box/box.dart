// ignore_for_file: public_member_api_docs

import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flamejam/game/components/box/behaviors/behaviors.dart';

class Box extends Entity {
  Box()
      : super(
          children: [],
          behaviors: [BoxBodyBehavior()],
        );
}
