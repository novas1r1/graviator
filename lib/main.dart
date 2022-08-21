import 'package:flamejam/app/app.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_audios/game_audios.dart';

final audioPlayer = FlameJamAudioPlayer();

Future<void> main() async {
  final futures = <Future>[];

  audioPlayer.load().map((loaderFunction) => futures.add(loaderFunction()));

  await Future.wait(futures);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GameCubit(),
        ),
        BlocProvider(
          create: (_) => AstronautCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.white,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.black,
            onBackground: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
          fontFamily: 'BitPotion',
        ),
        home: const App(),
      ),
    ),
  );
}
