// ignore_for_file: public_member_api_docs

import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BodyEntity extends Entity {
  BodyEntity({
    super.children,
    super.behaviors,
    required this.bodyComponent,
  }) : assert(
          () {
            if (children != null) {
              return children.whereType<BodyComponent>().isEmpty;
            }
            return true;
          }(),
          'Children must not contain a BodyComponent.',
        );

  final BodyComponent bodyComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(bodyComponent);
  }
}
