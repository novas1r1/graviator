import 'package:flame_forge2d/flame_forge2d.dart';

class BuildingBlock extends BodyComponent {
  /// building block constructor
  BuildingBlock({
    required this.positionX,
    required this.positionY,
  });

  /// default height
  static const double height = 16;

  /// default width
  static const double width = 16;

  /// the position X
  final double positionX;

  /// the position Y
  final double positionY;

  @override
  Body createBody() {
    final fixture = FixtureDef(
      PolygonShape()
        ..setAsBoxXY(
          width,
          height,
        ),
    );

    final body = BodyDef(
      position: Vector2(
        width * positionX * 2,
        height * positionY * 2,
      ),
      userData: this,
    );

    final worldBody = world.createBody(body)..createFixture(fixture);

    return worldBody;
  }
}
