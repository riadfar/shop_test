import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_decorations.dart';

enum AppTheme { light, dark }

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  ThemeData getTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return _buildLightTheme();
      case AppTheme.dark:
        return _buildDarkTheme();
    }
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceLight,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurfaceLight,
        onError: AppColors.onError,
      ),
      textTheme: AppTextStyles.textTheme,
      appBarTheme: AppDecorations.appBarThemeLight,
      elevatedButtonTheme: AppDecorations.elevatedButtonTheme,
      outlinedButtonTheme: AppDecorations.outlinedButtonTheme,
      inputDecorationTheme: AppDecorations.inputDecorationTheme,
      cardTheme: AppDecorations.cardTheme,
      iconTheme: const IconThemeData(color: AppColors.iconLight),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurfaceDark,
        onError: AppColors.onError,
      ),
      textTheme: AppTextStyles.darkTextTheme,
      appBarTheme: AppDecorations.appBarThemeDark,
      elevatedButtonTheme: AppDecorations.elevatedButtonTheme,
      outlinedButtonTheme: AppDecorations.outlinedButtonTheme,
      inputDecorationTheme: AppDecorations.inputDecorationTheme,
      cardTheme: AppDecorations.cardTheme,
      iconTheme: const IconThemeData(color: AppColors.iconDark),
    );
  }
}