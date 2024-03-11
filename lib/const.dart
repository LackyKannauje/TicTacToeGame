import 'dart:ui';
import 'package:flutter/material.dart';

//font
var gameFontFamily = 'SamuraiBlastRegular';

// check
bool isAppstarted = true;

var textContentColor = Colors.white;
var popUpPageColor = Color.fromARGB(151, 66, 64, 64);
var firstPlayerColor = Colors.blue;
var secondPlayerColor = Colors.purple;

var customGradient = LinearGradient(
  colors: [
    Color.fromARGB(163, 255, 175, 188),
    Color.fromARGB(163, 255, 195, 160)
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

var bgGradient = BoxDecoration(
  gradient: LinearGradient(
    colors: [Colors.orangeAccent, Colors.pinkAccent],
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
  ),
);
