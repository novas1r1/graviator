import 'package:flame/sprite.dart';
import 'package:flame_mini_sprite/flame_mini_sprite.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_sprite/mini_sprite.dart';

/// holds the sprite data
class MiniSpriteLibrary {
  static const _rawString =
      // ignore: leading_newlines_in_multiline_strings
      '''building_block_dynamic|16,16;19,1;6,0;1,1;3,0;7,1;2,0;1,1;5,0;5,1;1,0;3,1;6,0;3,1;1,0;2,1;2,0;3,1;4,0;3,1;2,0;2,1;3,0;3,1;2,0;3,1;3,0;3,1;3,0;6,1;3,0;3,1;1,0;1,1;3,0;4,1;5,0;3,1;4,0;4,1;3,0;1,1;1,0;3,1;3,0;6,1;2,0;1,1;1,0;3,1;2,0;3,1;2,0;3,1;2,0;3,1;2,0;3,1;4,0;3,1;2,0;2,1;1,0;3,1;3,0;1,1;2,0;3,1;1,0;5,1;2,0;2,1;4,0;7,1;4,0;1,1;1,0;1,1;3,0;19,1
building_block_static|16,16;19,1;10,0;7,1;8,0;5,1;1,0;3,1;6,0;3,1;1,0;2,1;2,0;3,1;4,0;3,1;2,0;2,1;3,0;3,1;2,0;3,1;3,0;2,1;4,0;6,1;4,0;2,1;5,0;4,1;5,0;2,1;5,0;4,1;5,0;2,1;4,0;6,1;4,0;2,1;3,0;3,1;2,0;3,1;3,0;2,1;2,0;3,1;4,0;3,1;2,0;2,1;1,0;3,1;6,0;3,1;1,0;5,1;8,0;7,1;10,0;19,1
player|16,12;4,0;4,1;7,0;1,1;1,0;1,1;2,0;1,1;6,0;1,1;4,0;1,1;6,0;2,1;2,0;2,1;8,0;2,1;4,0;1,1;1,0;4,1;2,0;1,1;1,0;3,1;1,0;1,1;1,0;1,1;4,0;2,1;2,0;2,1;1,0;1,1;1,0;2,1;1,0;1,1;3,0;1,1;2,0;1,1;1,0;2,1;1,0;1,1;6,0;1,1;4,0;1,1;6,0;6,1;7,0;1,1;2,0;1,1;8,0;1,1;2,0;2,1;7,0;1,1;3,0;1,1;6,0;3,1;1,0;4,1;4,0;1,1;1,0;1,1;1,0;4,1;1,0''';

  /// mini sprite library
  static final _library = MiniLibrary.fromDataString(_rawString);

  /// sprites map
  static Map<String, Sprite> sprites = {};

  /// load all sprites
  static Future<void> loadSprites({
    required double pixelSize,
    required Color color,
    Color? blankColor,
    Color? backgroundColor,
  }) async {
    sprites = await _library.toSprites(
      color: color,
      pixelSize: pixelSize,
      blankColor: blankColor,
      backgroundColor: backgroundColor,
    );
  }
}
