/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIngameGen {
  const $AssetsIngameGen();

  /// File path: assets/ingame/heart_empty.png
  AssetGenImage get heartEmpty =>
      const AssetGenImage('assets/ingame/heart_empty.png');

  /// File path: assets/ingame/heart_full.png
  AssetGenImage get heartFull =>
      const AssetGenImage('assets/ingame/heart_full.png');

  /// File path: assets/ingame/inventory.png
  AssetGenImage get inventory =>
      const AssetGenImage('assets/ingame/inventory.png');

  /// File path: assets/ingame/oxygen_level.png
  AssetGenImage get oxygenLevel =>
      const AssetGenImage('assets/ingame/oxygen_level.png');

  /// File path: assets/ingame/spaceship_computer.png
  AssetGenImage get spaceshipComputer =>
      const AssetGenImage('assets/ingame/spaceship_computer.png');

  /// File path: assets/ingame/spaceship_fuel.png
  AssetGenImage get spaceshipFuel =>
      const AssetGenImage('assets/ingame/spaceship_fuel.png');

  /// File path: assets/ingame/spaceship_wrench.png
  AssetGenImage get spaceshipWrench =>
      const AssetGenImage('assets/ingame/spaceship_wrench.png');
}

class $AssetsTutorialGen {
  const $AssetsTutorialGen();

  /// File path: assets/tutorial/astronaut.png
  AssetGenImage get astronaut =>
      const AssetGenImage('assets/tutorial/astronaut.png');

  /// File path: assets/tutorial/commander-fox.png
  AssetGenImage get commanderFox =>
      const AssetGenImage('assets/tutorial/commander-fox.png');

  /// File path: assets/tutorial/oxygen_tank.png
  AssetGenImage get oxygenTank =>
      const AssetGenImage('assets/tutorial/oxygen_tank.png');

  /// File path: assets/tutorial/oxygen_tank_label.png
  AssetGenImage get oxygenTankLabel =>
      const AssetGenImage('assets/tutorial/oxygen_tank_label.png');

  /// File path: assets/tutorial/portal.png
  AssetGenImage get portal => const AssetGenImage('assets/tutorial/portal.png');

  /// File path: assets/tutorial/spike_ball.png
  AssetGenImage get spikeBall =>
      const AssetGenImage('assets/tutorial/spike_ball.png');
}

class Assets {
  Assets._();

  static const $AssetsIngameGen ingame = $AssetsIngameGen();
  static const $AssetsTutorialGen tutorial = $AssetsTutorialGen();
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
    String? package,
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

  String get keyName => _assetName;
}
