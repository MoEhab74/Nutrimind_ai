import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,

  brightness: Brightness.light,

  scaffoldBackgroundColor: AppColors.background,

  colorScheme: const ColorScheme(
    brightness: Brightness.light,

    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,

    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,

    tertiary: AppColors.tertiary,
    onTertiary: AppColors.onTertiary,

    error: AppColors.error,
    onError: AppColors.onError,

    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    onSurfaceVariant: AppColors.onSurfaceVariant,

    surfaceContainerLow: AppColors.surfaceLow,
    surfaceContainer: AppColors.surfaceContainer,
    surfaceContainerHigh: AppColors.surfaceHigh,
    surfaceContainerHighest: AppColors.surfaceHighest,

    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    shadow: AppColors.shadow,
  ),

  textTheme: TextTheme(
  displayLarge: AppTextStyles.bold40,
  headlineLarge: AppTextStyles.semiBold32, 
  headlineMedium: AppTextStyles.semiBold28, 
  titleMedium: AppTextStyles.semiBold20,  
  bodyLarge: AppTextStyles.regular18,     
  bodyMedium: AppTextStyles.regular16,   
  labelMedium: AppTextStyles.medium14,    
  labelSmall: AppTextStyles.semiBold12,   
),

  dividerColor: AppColors.outlineVariant,

  cardColor: AppColors.surfaceLowest,

  splashFactory: InkRipple.splashFactory,

  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.onSurface,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceLow,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: const BorderSide(
        color: AppColors.outlineVariant,
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: const BorderSide(
        color: AppColors.outlineVariant,
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: const BorderSide(
        color: AppColors.error,
        width: 2,
      ),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(double.infinity, 56),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(double.infinity, 56),
      shape: const StadiumBorder(),
      side: const BorderSide(
        color: AppColors.outlineVariant,
      ),
    ),
  ),

  cardTheme: CardThemeData(
    elevation: 0,
    color: AppColors.surfaceLowest,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: const BorderSide(
        color: AppColors.border,
      ),
    ),
  ),
);