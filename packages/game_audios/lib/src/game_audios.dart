import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:clock/clock.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game_audios/gen/assets.gen.dart';

/// Sounds available to play.
enum FlameJamAudios { gravity_change, pain, plop, background_loop, loose, win }

/// Defines the contract of the creation of an [AudioPool].
typedef CreateAudioPool = Future<AudioPool> Function(
  String sound, {
  bool? repeating,
  int? maxPlayers,
  int? minPlayers,
  String? prefix,
});

/// Defines the contract for playing a single audio.
typedef PlaySingleAudio = Future<void> Function(String, {double volume});

/// Defines the contract for looping a single audio.
typedef LoopSingleAudio = Future<void> Function(String, {double volume});

/// Defines the contract for pre fetching an audio.
typedef PreCacheSingleAudio = Future<void> Function(String);

/// Defines the contract for configuring an [AudioCache] instance.
typedef ConfigureAudioCache = void Function(AudioCache);

abstract class _Audio {
  void play();

  Future<void> load();

  String prefixFile(String file) {
    return 'packages/game_audios/$file';
  }
}

class _SimplePlayAudio extends _Audio {
  _SimplePlayAudio({
    required this.preCacheSingleAudio,
    required this.playSingleAudio,
    required this.path,
    this.volume,
  });

  final PreCacheSingleAudio preCacheSingleAudio;
  final PlaySingleAudio playSingleAudio;
  final String path;
  final double? volume;

  @override
  Future<void> load() => preCacheSingleAudio(prefixFile(path));

  @override
  void play() {
    playSingleAudio(prefixFile(path), volume: volume ?? 1);
  }
}

class _LoopAudio extends _Audio {
  _LoopAudio({
    required this.preCacheSingleAudio,
    required this.loopSingleAudio,
    required this.path,
    this.volume,
  });

  final PreCacheSingleAudio preCacheSingleAudio;
  final LoopSingleAudio loopSingleAudio;
  final String path;
  final double? volume;

  @override
  Future<void> load() => preCacheSingleAudio(prefixFile(path));

  @override
  void play() {
    loopSingleAudio(prefixFile(path), volume: volume ?? 1);
  }
}

class _SingleLoopAudio extends _LoopAudio {
  _SingleLoopAudio({
    required super.preCacheSingleAudio,
    required super.loopSingleAudio,
    required super.path,
    super.volume,
  });

  bool _playing = false;

  @override
  void play() {
    if (!_playing) {
      super.play();
      _playing = true;
    }
  }
}

class _SingleAudioPool extends _Audio {
  _SingleAudioPool({
    required this.path,
    required this.createAudioPool,
    required this.maxPlayers,
  });

  final String path;
  final CreateAudioPool createAudioPool;
  final int maxPlayers;
  late AudioPool pool;

  @override
  Future<void> load() async {
    pool = await createAudioPool(
      prefixFile(path),
      maxPlayers: maxPlayers,
      prefix: '',
    );
  }

  @override
  void play() => pool.start();
}

class _RandomABAudio extends _Audio {
  _RandomABAudio({
    required this.createAudioPool,
    required this.seed,
    required this.audioAssetA,
    required this.audioAssetB,
    this.volume,
  });

  final CreateAudioPool createAudioPool;
  final Random seed;
  final String audioAssetA;
  final String audioAssetB;
  final double? volume;

  late AudioPool audioA;
  late AudioPool audioB;

  @override
  Future<void> load() async {
    await Future.wait(
      [
        createAudioPool(
          prefixFile(audioAssetA),
          maxPlayers: 4,
          prefix: '',
        ).then((pool) => audioA = pool),
        createAudioPool(
          prefixFile(audioAssetB),
          maxPlayers: 4,
          prefix: '',
        ).then((pool) => audioB = pool),
      ],
    );
  }

  @override
  void play() {
    (seed.nextBool() ? audioA : audioB).start(volume: volume ?? 1);
  }
}

class _ThrottledAudio extends _Audio {
  _ThrottledAudio({
    required this.preCacheSingleAudio,
    required this.playSingleAudio,
    required this.path,
    required this.duration,
  });

  final PreCacheSingleAudio preCacheSingleAudio;
  final PlaySingleAudio playSingleAudio;
  final String path;
  final Duration duration;

  DateTime? _lastPlayed;

  @override
  Future<void> load() => preCacheSingleAudio(prefixFile(path));

  @override
  void play() {
    final now = clock.now();
    if (_lastPlayed == null ||
        (_lastPlayed != null && now.difference(_lastPlayed!) > duration)) {
      _lastPlayed = now;
      playSingleAudio(prefixFile(path));
    }
  }
}

/// {@template flame_jam_audio_player}
/// Sound manager for the pinball game.
/// {@endtemplate}
class FlameJamAudioPlayer {
  /// {@macro flame_jam_audio_player}
  FlameJamAudioPlayer({
    CreateAudioPool? createAudioPool,
    PlaySingleAudio? playSingleAudio,
    LoopSingleAudio? loopSingleAudio,
    PreCacheSingleAudio? preCacheSingleAudio,
    ConfigureAudioCache? configureAudioCache,
    Random? seed,
  })  : _createAudioPool = createAudioPool ?? AudioPool.create,
        _playSingleAudio = playSingleAudio ?? FlameAudio.audioCache.play,
        _loopSingleAudio = loopSingleAudio ?? FlameAudio.audioCache.loop,
        _preCacheSingleAudio =
            preCacheSingleAudio ?? FlameAudio.audioCache.load,
        _configureAudioCache = configureAudioCache ??
            ((AudioCache a) {
              a.prefix = '';
            }),
        _seed = seed ?? Random() {
    audios = {
      FlameJamAudios.loose: _SimplePlayAudio(
        preCacheSingleAudio: _preCacheSingleAudio,
        playSingleAudio: _playSingleAudio,
        path: Assets.music.loose,
        volume: .3,
      ),
      FlameJamAudios.win: _SimplePlayAudio(
        preCacheSingleAudio: _preCacheSingleAudio,
        playSingleAudio: _playSingleAudio,
        path: Assets.music.win,
      ),
      FlameJamAudios.background_loop: _SingleLoopAudio(
        preCacheSingleAudio: _preCacheSingleAudio,
        loopSingleAudio: _loopSingleAudio,
        path: Assets.music.backgroundLoop,
        volume: .04,
      ),
      FlameJamAudios.pain: _SimplePlayAudio(
        preCacheSingleAudio: _preCacheSingleAudio,
        playSingleAudio: _playSingleAudio,
        path: Assets.sfx.painOne,
        volume: .5,
      ),
      FlameJamAudios.gravity_change: _SimplePlayAudio(
        preCacheSingleAudio: _preCacheSingleAudio,
        playSingleAudio: _playSingleAudio,
        path: Assets.sfx.gravityChange,
        volume: .5,
      ),
      FlameJamAudios.plop: _SimplePlayAudio(
        preCacheSingleAudio: _preCacheSingleAudio,
        playSingleAudio: _playSingleAudio,
        path: Assets.sfx.plopOne,
        volume: .5,
      ),
    };
  }

  final CreateAudioPool _createAudioPool;

  final PlaySingleAudio _playSingleAudio;

  final LoopSingleAudio _loopSingleAudio;

  final PreCacheSingleAudio _preCacheSingleAudio;

  final ConfigureAudioCache _configureAudioCache;

  final Random _seed;

  /// Registered audios on the Player.
  @visibleForTesting
  // ignore: library_private_types_in_public_api
  late final Map<FlameJamAudios, _Audio> audios;

  /// Loads the sounds effects into the memory.
  List<Future<void> Function()> load() {
    _configureAudioCache(FlameAudio.audioCache);

    return audios.values.map((a) => a.load).toList();
  }

  /// Plays the received audio.
  void play(FlameJamAudios audio) {
    assert(
      audios.containsKey(audio),
      'Tried to play unregistered audio $audio',
    );
    audios[audio]?.play();
  }
}
