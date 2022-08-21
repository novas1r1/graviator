/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsMusicGen {
  const $AssetsMusicGen();

  /// File path: assets/music/background_loop.mp3
  String get backgroundLoop => 'assets/music/background_loop.mp3';

  /// File path: assets/music/loose.mp3
  String get loose => 'assets/music/loose.mp3';

  /// File path: assets/music/win.mp3
  String get win => 'assets/music/win.mp3';
}

class $AssetsSfxGen {
  const $AssetsSfxGen();

  /// File path: assets/sfx/gravity_change.mp3
  String get gravityChange => 'assets/sfx/gravity_change.mp3';

  /// File path: assets/sfx/jetpack.mp3
  String get jetpack => 'assets/sfx/jetpack.mp3';

  /// File path: assets/sfx/level_complete.mp3
  String get levelComplete => 'assets/sfx/level_complete.mp3';

  /// File path: assets/sfx/pain_one.mp3
  String get painOne => 'assets/sfx/pain_one.mp3';

  /// File path: assets/sfx/pain_two.mp3
  String get painTwo => 'assets/sfx/pain_two.mp3';

  /// File path: assets/sfx/plop_four.mp3
  String get plopFour => 'assets/sfx/plop_four.mp3';

  /// File path: assets/sfx/plop_one.mp3
  String get plopOne => 'assets/sfx/plop_one.mp3';

  /// File path: assets/sfx/plop_three.mp3
  String get plopThree => 'assets/sfx/plop_three.mp3';

  /// File path: assets/sfx/plop_two.mp3
  String get plopTwo => 'assets/sfx/plop_two.mp3';
}

class Assets {
  Assets._();

  static const $AssetsMusicGen music = $AssetsMusicGen();
  static const $AssetsSfxGen sfx = $AssetsSfxGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package = 'game_audios',
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/game_audios/$_assetName';
}
