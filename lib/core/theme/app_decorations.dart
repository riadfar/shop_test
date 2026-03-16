import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  AppDecorations._();

  // AppBar Themes
  static const AppBarTheme appBarThemeLight = AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.onPrimary),
    titleTextStyle: TextStyle(
      color: AppColors.onPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );

  static const AppBarTheme appBarThemeDark = AppBarTheme(
    backgroundColor: AppColors.surfaceDark,
    foregroundColor: AppColors.onSurfaceDark,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.onSurfaceDark),
    titleTextStyle: TextStyle(
      color: AppColors.onSurfaceDark,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  );

  // Button Themes
  static final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  // Input Decoration Theme
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceLight,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.borderLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.borderLight),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    labelStyle: const TextStyle(
      color: AppColors.onSurfaceLight,
      fontSize: 16,
    ),
    errorStyle: const TextStyle(
      color: AppColors.error,
      fontSize: 12,
    ),
  );

  // Card Theme
  static final CardThemeData cardTheme = CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(8),
  );

  // Box Decorations
  static BoxDecoration cardDecorationLight = BoxDecoration(
    color: AppColors.surfaceLight,
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: AppColors.shadowLight,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration cardDecorationDark = BoxDecoration(
    color: AppColors.surfaceDark,
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: AppColors.shadowDark,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );

  // Input Decorations
  static InputDecoration searchInputDecoration = InputDecoration(
    filled: true,
    fillColor: AppColors.surfaceLight,
    hintText: 'Search...',
    prefixIcon: const Icon(Icons.search, color: AppColors.iconLight),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  );
}
