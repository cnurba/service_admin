import 'package:flutter/material.dart';

class AppTheme {
  // Define your theme properties here
  /// Create a light theme. with primary green and brightness light.

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.green[50],
      shadowColor: Colors.green[200],
      elevation: 1,

     // margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.grey[800]),
      bodyLarge: TextStyle(color: Colors.grey[900]),
      titleMedium: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),
      bodySmall: TextStyle(color: Colors.grey[700]),
    ),

  );

}