import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const MaterialColor primaryColor = Colors.blue;
  static const MaterialAccentColor accentColor = Colors.blueAccent;  
  static const Color backgroundColor1 = Color(0xFFE4f9f7);
  static const Color backgroundColor2 = Colors.white54;  
  static const Color disabledTextColor = Colors.white38;
  static const Color floatingButtonForegroundColor = Colors.white;
  static const Color linkColor = Color(0xFF043ed2);
  static const Color dangerColor = Colors.redAccent;

  static TextStyle textlinkStyle = const TextStyle(
    color: linkColor,
    decoration: TextDecoration.underline,
  );

  static TextStyle appDrawerListTileTextStyle = const TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle failureMessageStyle = const TextStyle(
    color: Colors.grey,
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor1,
    brightness: Brightness.light,
    primarySwatch: primaryColor,
    accentColor: accentColor,
    dividerColor: Colors.grey,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: backgroundColor2,
      type: BottomNavigationBarType.fixed,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
