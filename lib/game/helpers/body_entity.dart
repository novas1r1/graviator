// ignore_for_file: public_member_api_docs

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BodyEntity<T extends BodyComponent> extends Entity {
  BodyEntity({
    Iterable<Component>? children,
    super.behaviors,
    required this.bodyComponent,
  })  : assert(
          () {
            if (children != null) {
              return children.whereType<BodyComponent>().isEmpty;
            }
            return true;
          }(),
          'Children must not contain a BodyComponent.',
        ),
        _children = children;

  final T bodyComponent;

  Type get type => T;

  final Iterable<Component>? _children;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(bodyComponent);
    if (_children != null) await bodyComponent.addAll(_children!);
  }
}
