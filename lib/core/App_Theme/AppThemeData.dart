

import 'package:flutter/material.dart';

abstract class AppTheme {
  static  ThemeData appDarkThemeData = ThemeData(
    textTheme:const TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color:Colors.white70
        )),
    fontFamily: "Khand-Regular",
    canvasColor: Colors.grey.shade900,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        color: Colors.blue,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: 'OleoScript-Regular')),
  );

  static  ThemeData appLightThemeData = ThemeData(
  textTheme:  const TextTheme(
  displayLarge: TextStyle(color: Colors.white),
  displayMedium: TextStyle(color: Colors.black),
  bodyMedium: TextStyle(color:Colors.black
  )),
  fontFamily: "Khand-Regular",
  backgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
  iconTheme: IconThemeData(
  color: Colors.white,
  ),
  color: Colors.blue,
  titleTextStyle: TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontFamily: 'OleoScript-Regular')
  ),
  );





}