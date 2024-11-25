import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';

// Light Theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: whiteScheme,
  appBarTheme: AppBarTheme(
    color: whiteColor,
    elevation: 0,
    iconTheme: IconThemeData(color: whiteColor),
    titleTextStyle: h4Bold.copyWith(color: primaryColor),
  ),
  textTheme: TextTheme(
    headlineLarge: h1Bold,
    headlineMedium: h2Bold,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.tealAccent,
  scaffoldBackgroundColor: blackScheme,
  appBarTheme: AppBarTheme(
    color: Colors.tealAccent[700],
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white70),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.tealAccent,
    textTheme: ButtonTextTheme.primary,
  ),
);
