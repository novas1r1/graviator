import 'package:flamejam/app/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'BitPotion',
      ),
      home: const App(),
    ),
  );
}
