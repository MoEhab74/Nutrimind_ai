import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

const _primary = Color(0xff4AE183);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,

  brightness: Brightness.dark,

  scaffoldBackgroundColor: const Color(0xff111312),

  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: _primary,
    onPrimary: Colors.black,
    primaryContainer: Color(0xff005227),
    onPrimaryContainer: Color(0xff6BFE9C),

    secondary: Color(0xff97D5A3),
    onSecondary: Colors.black,
    secondaryContainer: Color(0xff1E3625),
    onSecondaryContainer: Color(0xffB3F1BD),

    tertiary: Color(0xffBDC7D9),
    onTertiary: Colors.black,
    tertiaryContainer: Color(0xff3B4554),
    onTertiaryContainer: Color(0xffD9E3F6),

    error: Color(0xffFFB4AB),
    onError: Colors.black,
    errorContainer: Color(0xff93000A),
    onErrorContainer: Color(0xffFFDAD6),

    surface: Color(0xff111312),
    onSurface: Colors.white,
    onSurfaceVariant: Color(0xffC1C9C2),

    surfaceContainerLow: Color(0xff1A1C1B),
    surfaceContainer: Color(0xff202322),
    surfaceContainerHigh: Color(0xff272A29),
    surfaceContainerHighest: Color(0xff2E3130),

    outline: Color(0xff8C938D),
    outlineVariant: Color(0xff2D322F),
    shadow: Color(0x33000000),
  ),

  textTheme: TextTheme(
    displayLarge: AppTextStyles.bold40.copyWith(color: Colors.white),
    headlineLarge: AppTextStyles.semiBold32.copyWith(color: Colors.white),
    headlineMedium: AppTextStyles.semiBold28.copyWith(color: Colors.white),
    titleMedium: AppTextStyles.semiBold20.copyWith(color: Colors.white),
    bodyLarge: AppTextStyles.regular18.copyWith(color: Colors.white),
    bodyMedium: AppTextStyles.regular16.copyWith(color: Colors.white70),
    labelMedium: AppTextStyles.medium14.copyWith(color: Colors.white70),
    labelSmall: AppTextStyles.semiBold12.copyWith(color: Colors.white60),
  ),

  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: Colors.transparent,
  ),

  dividerColor: Colors.white12,

  cardTheme: CardThemeData(
    color: const Color(0xff202322),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: const BorderSide(color: Colors.white10),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xff232625),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: const BorderSide(color: _primary, width: 2),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(double.infinity, 56),
      backgroundColor: _primary,
      foregroundColor: Colors.black,
      shape: const StadiumBorder(),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(double.infinity, 56),
      side: const BorderSide(color: Colors.white24),
      shape: const StadiumBorder(),
    ),
  ),
);
