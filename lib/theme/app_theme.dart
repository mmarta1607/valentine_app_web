import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Colors.white;
  static const Color primary = Color(0xFFFF6F91); // główny róż
  static const Color black = Colors.black;
  static const Color gray = Color.fromARGB(255, 113, 113, 113);
  static const Color rose = Color(0xFFFFF6F8); // pastelowy róż
  static const Color error = Color(0xFFE53935);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,

      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.gray,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,

        labelStyle: const TextStyle(
          color: AppColors.gray,
        ),

        floatingLabelStyle: const TextStyle(
          color: AppColors.gray,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.4),
            width: 1.5,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.4),
            width: 1.5,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),

        errorStyle: const TextStyle(
          color: AppColors.error,
        ),
      ),


      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 32,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
