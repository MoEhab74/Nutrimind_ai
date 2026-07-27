import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  //==========================
  // Primary
  //==========================

  static const primary = Color(0xFF006D37);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFF2ECC71);
  static const onPrimaryContainer = Color(0xFF005027);

  static const secondary = Color(0xFF306A41);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFB0EEBB);
  static const onSecondaryContainer = Color(0xFF356E45);

  static const tertiary = Color(0xFF555F6F);
  static const onTertiary = Color(0xFFFFFFFF);
  static const tertiaryContainer = Color(0xFFA9B3C5);
  static const onTertiaryContainer = Color(0xFF3B4554);

  //==========================
  // Surface
  //==========================

  static const background = Color(0xFFF8FAF8);

  static const surface = Color(0xFFF8FAF8);
  static const surfaceDim = Color(0xFFD8DAD9);
  static const surfaceBright = Color(0xFFF8FAF8);

  static const surfaceLowest = Color(0xFFFFFFFF);
  static const surfaceLow = Color(0xFFF2F4F2);
  static const surfaceContainer = Color(0xFFECEEEC);
  static const surfaceHigh = Color(0xFFE6E9E7);
  static const surfaceHighest = Color(0xFFE1E3E1);

  static const surfaceVariant = Color(0xFFE1E3E1);

  //==========================
  // Text
  //==========================

  static const onBackground = Color(0xFF191C1B);

  static const onSurface = Color(0xFF191C1B);
  static const onSurfaceVariant = Color(0xFF3D4A3E);

  static const inverseSurface = Color(0xFF2E3130);
  static const inverseOnSurface = Color(0xFFEFF1EF);

  //==========================
  // Outline
  //==========================

  static const outline = Color(0xFF6C7B6D);
  static const outlineVariant = Color(0xFFBBCBBB);

  //==========================
  // Error
  //==========================

  static const error = Color(0xFFBA1A1A);
  static const onError = Color(0xFFFFFFFF);

  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF93000A);

  //==========================
  // Fixed
  //==========================

  static const primaryFixed = Color(0xFF6BFE9C);
  static const primaryFixedDim = Color(0xFF4AE183);

  static const secondaryFixed = Color(0xFFB3F1BD);
  static const secondaryFixedDim = Color(0xFF97D5A3);

  static const tertiaryFixed = Color(0xFFD9E3F6);
  static const tertiaryFixedDim = Color(0xFFBDC7D9);

  //==========================
  // Extra
  //==========================

  static const border = Color(0xFFE5E7EB);

  static const shadow = Color(0x0F000000);

  static const glow = Color(0x14006D37);
}