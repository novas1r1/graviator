// ignore_for_file: public_member_api_docs

import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BodyEntity extends Entity {
  BodyEntity({
    super.children,
    super.behaviors,
    required BodyComponent bodyComponent,
  }) : _bodyComponent = bodyComponent;

  late final Body body;

  final BodyComponent _bodyComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(_bodyComponent);
    body = _bodyComponent.body;
  }
}
