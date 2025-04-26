
import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFE7EAEC);
  static const Color white = Colors.white;
  static const Color primary = Color(0xFF1A3A6D);
  static const Color textPrimary = Color(0xFF596D7E);
  static const Color textSecondary = Color(0xFF596D7E);
  static const Color textHint = Color(0xFFB0BEC5);
  static const Color divider = Color(0xFFCFD8DC);
  static const Color shadow = Color(0x33000000);
  static const Color buttonBackground = Color(0xFFE7EAEC);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE57373);
  static const Color blueText = Color(0xFF122E46);
  static const Color greyText = Color(0xFFABB5BD);
}

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.textSecondary,
      surface: AppColors.white,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onError: AppColors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
      labelMedium: TextStyle(color: AppColors.textHint),
    ),
    dividerColor: AppColors.divider,
    shadowColor: AppColors.shadow,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonBackground,
        foregroundColor: AppColors.blueText,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.textHint),
      border: OutlineInputBorder(),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF3F6BAF), 
    scaffoldBackgroundColor: const Color(0xFF121212),     colorScheme: const ColorScheme.dark(
      primary: Color(0xFF3F6BAF),
      secondary: Color(0xFFB0B0B0), // Medium grey
      surface: Color(0xFF1E1E1E), // Darker surface
      error: Color(0xFFEF5350), // Brighter red
      onPrimary: Colors.white,
      onSecondary: Color(0xFFE0E0E0), // Light grey
      onSurface: Color(0xFFE0E0E0),
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFE0E0E0)),
      bodyMedium: TextStyle(color: Color(0xFFB0B0B0)),
      labelMedium: TextStyle(color: Color(0xFF757575)), // Darker hint
    ),
    dividerColor: const Color(0xFF424242), // Dark grey divider
    shadowColor: const Color(0x66000000), // Slightly opaque shadow
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2A2A2A), // Dark button background
        foregroundColor: const Color(0xFF90CAF9), // Light blue text
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Color(0xFF757575)),
      border: OutlineInputBorder(),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
    ),
  );
}