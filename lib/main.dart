import 'package:flamejam/app/app.dart';
import 'package:flamejam/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => GameCubit(),
      child: MaterialApp(
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
