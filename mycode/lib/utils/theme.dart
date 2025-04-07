// lib/utils/theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTheme {
  // Brand colors
  static const Color primaryColor = Color(0xFF54408C);
  static const Color secondaryColor = Color(0xFF7D64C3);
  static const Color accentColor = Color(0xFFE5DEF8);
  
  // Light theme colors
  static const Color lightBackgroundColor = Colors.white;
  static const Color lightCardColor = Colors.white;
  static const Color lightTextColor = Color(0xFF121212);
  static const Color lightSecondaryTextColor = Color(0xFF525252);
  
  // Dark theme colors
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkCardColor = Color(0xFF1E1E1E);
  static const Color darkTextColor = Colors.white;
  static const Color darkSecondaryTextColor = Color(0xFFBBBBBA);

  // Light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: lightBackgroundColor,
    cardColor: lightCardColor,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBackgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: lightTextColor),
      titleTextStyle: TextStyle(
        color: lightTextColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: lightTextColor, fontSize: 16, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: lightTextColor, fontSize: 16),
      bodyMedium: TextStyle(color: lightTextColor, fontSize: 14),
      bodySmall: TextStyle(color: lightSecondaryTextColor, fontSize: 12),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightBackgroundColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  // Dark theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: darkTextColor),
      titleTextStyle: TextStyle(
        color: darkTextColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentColor,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: darkTextColor, fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: darkTextColor, fontSize: 16, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: darkTextColor, fontSize: 16),
      bodyMedium: TextStyle(color: darkTextColor, fontSize: 14),
      bodySmall: TextStyle(color: darkSecondaryTextColor, fontSize: 12),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkBackgroundColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}