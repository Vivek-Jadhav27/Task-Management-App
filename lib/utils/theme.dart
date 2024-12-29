import 'package:flutter/material.dart';

class Mytheme {
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto',
    appBarTheme:  const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 24, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          headlineSmall: TextStyle(
          fontSize: 26, fontWeight: FontWeight.normal, color: Colors.white),
    ),
    floatingActionButtonTheme:const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    buttonTheme:const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.grey[200],
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal, brightness: Brightness.dark),
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Roboto',
    appBarTheme:const AppBarTheme(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    textTheme:const TextTheme(
      bodyLarge: TextStyle(fontSize: 24, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          headlineSmall: TextStyle(
          fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
   
    ),
    
    
    floatingActionButtonTheme:const FloatingActionButtonThemeData(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.black,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.teal,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.grey[800],
    ),
  );
}
