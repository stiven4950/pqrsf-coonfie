import 'package:flutter/material.dart';

final lightThemeData = ThemeData(
  //primarySwatch: Color(0xFF596FD7),
  backgroundColor: Colors.white,
  cardColor: Colors.blueGrey[50],
  primaryTextTheme: TextTheme(
    button: TextStyle(
      color: Colors.white,
      decorationColor: Colors.blueGrey[300],
    ),
    subtitle2: TextStyle(
      color: Colors.blueGrey[900],
    ),
    subtitle1: const TextStyle(
      color: Colors.black,
    ),
    headline1: TextStyle(color: Colors.blueGrey[800]),
  ),
  //bottomAppBarColor: Colors.blueGrey[900],
  //iconTheme: const IconThemeData(color: Colors.blueGrey),
  brightness: Brightness.light,
  fontFamily: "Poppins",
  scrollbarTheme: const ScrollbarThemeData().copyWith(
    thumbColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.5)),
  ),
);
