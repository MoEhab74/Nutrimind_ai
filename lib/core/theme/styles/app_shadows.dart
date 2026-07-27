import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppShadows {
  static const card = [
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 50,
      offset: Offset(0, 16),
    ),
  ];

  static const glow = [
    BoxShadow(
      color: AppColors.glow,
      blurRadius: 60,
      offset: Offset(0, 24),
    ),
  ];
}