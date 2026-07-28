import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';

abstract class AppTextStyles {
  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    double letterSpacing = 0,
    Color color = AppColors.onSurface,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle get bold40 => _base(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 48 / 40,
    letterSpacing: -.02,
  );

  static TextStyle get semiBold32 => _base(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 40 / 32,
    letterSpacing: -.01,
  );

  static TextStyle get semiBold28 =>
      _base(fontSize: 28, fontWeight: FontWeight.w600, height: 36 / 28);

  static TextStyle get semiBold20 =>
      _base(fontSize: 20, fontWeight: FontWeight.w600, height: 28 / 20);

  static TextStyle get regular18 =>
      _base(fontSize: 18, fontWeight: FontWeight.w400, height: 28 / 18);

  static TextStyle get regular16 =>
      _base(fontSize: 16, fontWeight: FontWeight.w400, height: 24 / 16);

  static TextStyle get medium14 => _base(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: .01,
  );

  static TextStyle get semiBold12 => _base(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
    letterSpacing: .05,
  );

  static TextStyle get semiBold16 => _base(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
    color: AppColors.onPrimary,
  );
}
